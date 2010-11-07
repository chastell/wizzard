# encoding: UTF-8

module Wizzard

  describe App do

    RSpec::Matchers.define :json_decode_to do |expected|
      match do |actual|
        actual.ok? and
        actual.headers['Content-Type'] == 'application/json;charset=utf-8' and
        JSON.parse(actual.body) == expected
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

    end

  end

end
