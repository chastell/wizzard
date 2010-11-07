module Wizzard

  class App < Sinatra::Base

    before do
      content_type 'application/json'
    end

    get '/dicts' do
      Aspell.list_dicts.map(&:code).uniq.to_json
    end

    get '/dicts/:dict/check' do |dict|
      [Aspell.new(dict).check(params['text'])].to_json
    end

  end

end
