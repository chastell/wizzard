module Wizzard

  class App < Sinatra::Base

    get '/dicts' do
      content_type 'application/json'
      Aspell.list_dicts.map(&:code).uniq.to_json
    end

    get '/dicts/:dict/check' do |dict|
      content_type 'application/json'
      [Aspell.new(dict).check(params['text'])].to_json
    end

  end

end
