require 'rubygems'
require 'bundler'
Bundler::GemHelper.install_tasks

task :test do
  require File.join(File.expand_path(File.dirname(__FILE__)), 'test', 'test_helper.rb')
  Dir[ File.join(File.expand_path(File.dirname(__FILE__)), 'test', '**', '*_test.rb') ].each {|file| require file }
end