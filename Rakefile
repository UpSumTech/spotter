# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "spotter"
  gem.homepage = "http://github.com/sumanmukherjee03/spotter"
  gem.license = "MIT"
  gem.summary = %Q{A gem that implements a simple interface for adding observers to your classes}
  gem.description = %Q{Gem that provides a simple interface for adding observers to your ruby classes}
  gem.email = "sumanmukherjee03@gmail.com"
  gem.authors = ["Suman Mukherjee"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

task :default => :test
