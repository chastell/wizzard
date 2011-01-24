# encoding: UTF-8

module Wizzard

  describe App do

    RSpec::Matchers.define :json_decode_to do |expected|
      match do |actual|
        [
          actual.ok?,
          actual.headers['Content-Type'] == 'application/json',
          JSON.parse(actual.body) == expected,
        ].all?
      end
      failure_message_for_should do |actual|
        "expected #{actual.body} to JSON-decode to #{expected}"
      end
    end

    include Rack::Test::Methods

    def app
      App
    end

    context 'information queries' do

      it 'lists the available dictionaries' do
        get '/dicts'
        last_response.should json_decode_to ['en', 'en_CA', 'en_GB', 'en_US']
      end

    end

    context 'spelling queries' do

      it 'checks a given word’s spelling according to the specified dictionary' do
        get '/dicts/en/check?text=colour'
        last_response.should json_decode_to [true]

        get '/dicts/en_GB/check?text=colour'
        last_response.should json_decode_to [true]

        get '/dicts/en_US/check?text=colour'
        last_response.should json_decode_to [false]
      end

      it 'checks a sentence’s spelling according to the specified dictionary' do
        get '/dicts/en_GB/check?text=colour+of+magic'
        last_response.should json_decode_to [true]

        get '/dicts/en_US/check?text=colour+of+magic'
        last_response.should json_decode_to [false]
      end

      it 'finds misspelled words in sentences according to the specified dictionary' do
        get '/dicts/en/errors?text=a+sentence+wtih+smoe+errors'
        last_response.should json_decode_to ['wtih', 'smoe']
      end

    end

    context 'correcting queries' do

      it 'corrects a given word’s spelling according to the specified dictionary' do
        get '/dicts/en_GB/autocorrect?text=sanitize'
        last_response.should json_decode_to ['sanitise']

        get '/dicts/en_US/autocorrect?text=sanitise'
        last_response.should json_decode_to ['sanitize']
      end

      it 'corrects a sentence’s spelling according to the specified dictionary' do
        get '/dicts/en_GB/autocorrect?text=sanitised+aluminum'
        last_response.should json_decode_to ['sanitised aluminium']

        get '/dicts/en_US/autocorrect?text=sanitised+aluminum'
        last_response.should json_decode_to ['sanitized aluminum']
      end

      it 'suggests alternative spellings for a given word' do
        get '/dicts/en_GB/suggest?text=rewolutionary'
        last_response.should json_decode_to ['revolutionary', 'evolutionary', 'reflationary', "revolutionary's"]
      end

    end

  end

end
