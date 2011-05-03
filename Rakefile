# require 'rubygems'
require 'bundler'
Bundler::GemHelper.install_tasks

testing_rubies = %w[1.8.7 1.9.2 ree jruby rbx]

task :test do
  require File.join(File.expand_path(File.dirname(__FILE__)), 'test', 'test_helper.rb')
  Dir[ File.join(File.expand_path(File.dirname(__FILE__)), 'test', '**', '*_test.rb') ].each {|file| require file }
end

task :record_tests do
  system "rvm --json #{testing_rubies.join(',')} rake test > test/results/#{Time.now.strftime('%Y-%m-%d-%H%M%S')}.json"
end

namespace :install do
  task :bundles do
    puts "Installing bundles for rubies..."
    testing_rubies.each do |ruby|
      puts "--------------------"
      puts " #{ruby}"
      puts "--------------------"
      exec "rvm use #{ruby}"
      puts "- Installing bundler"
      exec "gem install bundler --no-rdoc --no-ri"
      puts "- Installing bundle"
      exec "bundle install"
    end
  end
end