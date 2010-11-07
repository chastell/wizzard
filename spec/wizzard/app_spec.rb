# encoding: UTF-8

module Wizzard

  describe App do

    include Rack::Test::Methods

    def app
      App
    end

    context 'information queries' do

      it 'lists the available dictionaries' do
        get '/dicts'
        last_response.should be_ok
        last_response.headers['Content-Type'].should == 'application/json;charset=utf-8'
        JSON.parse(last_response.body).should include 'en'
      end

    end

    context 'spelling queries' do

      it 'checks a given word’s spelling according to the specified dictionary' do
        get '/dicts/en/check?text=colour'
        last_response.should be_ok
        last_response.headers['Content-Type'].should == 'application/json;charset=utf-8'
        JSON.parse(last_response.body).should == [true]

        get '/dicts/en_GB/check?text=colour'
        last_response.should be_ok
        last_response.headers['Content-Type'].should == 'application/json;charset=utf-8'
        JSON.parse(last_response.body).should == [true]

        get '/dicts/en_US/check?text=colour'
        last_response.should be_ok
        last_response.headers['Content-Type'].should == 'application/json;charset=utf-8'
        JSON.parse(last_response.body).should == [false]
      end

    end

  end

end
