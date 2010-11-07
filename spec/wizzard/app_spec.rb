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

  end

end
