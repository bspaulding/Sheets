# require 'rubygems'
require 'bundler'
Bundler::GemHelper.install_tasks

testing_rubies = %w[1.8.7 1.9.2 ree ree-1.8.7-2010.01 jruby rbx]

task :default => :test

namespace :test do
  task :current do
    require File.join(File.expand_path(File.dirname(__FILE__)), 'test', 'test_helper.rb')
    Dir[ File.join(File.expand_path(File.dirname(__FILE__)), 'test', '**', '*_test.rb') ].each {|file| require file }
  end

  task :all do
    File.delete('test/results.json') if File.exists?('test/results.json')
    system "rvm --json #{testing_rubies.join(',')} rake test > test/results.json"
  end
end

task :test => ['test:current']

namespace :install do
  def ruby_installed?(ruby)
    !%x[rvm use #{ruby}].include?('not installed')
  end

  task :rubies do
    testing_rubies.each do |ruby|
      puts ruby
      puts "----------"

      ruby_installed?(ruby) ? puts('- Installed.') : system("rvm install #{ruby}")
    end
  end

  task :bundles => :rubies do
    testing_rubies.each do |ruby|
      puts ruby
      puts "----------"

      puts '- Installing bundler...'
      system "rvm #{ruby} gem install --no-rdoc --no-ri bundler"
      
      puts '- Installing bundle...'
      system "rvm #{ruby} exec bundle install"
    end
  end
end

namespace :clean do
  task :rbx do
    Dir[ File.join(File.expand_path(File.dirname(__FILE__)), '**', '*.rbc') ].each {|file| File.delete(file) }
  end
end