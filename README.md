Wizzard
=======

Wizzard¹ is a spell-checking and -correcting webservice, written for the [s3-e1 exercise](https://github.com/rmu/s3-e1) of [Ruby Mendicant University](http://university.rubymendicant.com).

¹ [obviously](http://en.wikipedia.org/wiki/Rincewind#Fictional_history)



requirements
------------

Wizzard requires a working raspell library – please refer to [raspell’s README](https://github.com/fauna/raspell#readme) for Aspell setup instructions.

At the moment of this writing, [Dylan Markow’s fork](https://github.com/dmarkow/raspell) works under Ruby 1.9.2.



usage
-----

Wizzard is a Sinatra-based webservice, and the example `config.ru` file can be used with the `rackup` command (or any Rack-compatible server such as Shotgun, Thin or Unicorn).

Please refer to the [`spec/wizzard/app_spec.rb`](https://github.com/chastell/s3-e1/blob/master/server/spec/wizzard/app_spec.rb) file and the [Borrowing library](https://github.com/chastell/s3-e1/tree/master/client) for functionality and usage examples.



---

© MMX-MMXI Piotr Szotkowski <chastell@chastell.net>, licensed under AGPL 3 (see LICENCE)
