require 'test/unit'

puts 'Loading Test Generators'
Dir[ File.join(File.expand_path(File.dirname(__FILE__)), 'generators', '*.rb') ].each {|file| puts "- #{file}"; require file }

require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib', 'sheets.rb')