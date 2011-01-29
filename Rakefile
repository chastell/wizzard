require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new :spec

desc 'Run Wizzard console'
task :console do
  require 'irb'
  require_relative 'lib/wizzard'
  include Wizzard
  ARGV.clear
  IRB.start
end
