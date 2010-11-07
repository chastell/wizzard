module Wizzard

  class App < Sinatra::Base

    before do
      content_type 'application/json'
    end

    get '/dicts' do
      Aspell.list_dicts.map(&:code).uniq.to_json
    end

    get '/dicts/:dict/check' do |dict|
      spell = Aspell.new(dict)
      [params['text'].split.all? { |word| spell.check(word) }].to_json
    end

  end

end
