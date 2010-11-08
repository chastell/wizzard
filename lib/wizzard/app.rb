module Wizzard

  class App < Sinatra::Base

    before do
      content_type 'application/json'
    end

    get '/dicts' do
      Aspell.list_dicts.map(&:code).uniq.to_json
    end

    get '/dicts/:dict/autocorrect' do |dict|
      spell = Aspell.new(dict)
      [params['text'].split.map { |word| spell.suggest(word).first }.join(' ')].to_json
    end

    get '/dicts/:dict/check' do |dict|
      [Aspell.new(dict).list_misspelled([params['text']]).empty?].to_json
    end

    get '/dicts/:dict/errors' do |dict|
      Aspell.new(dict).list_misspelled([params['text']]).to_json
    end

    get '/dicts/:dict/suggest' do |dict|
      Aspell.new(dict).suggest(params['text']).to_json
    end

  end

end
