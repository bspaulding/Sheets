# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sheets/version"

Gem::Specification.new do |s|
  s.name        = "sheets"
  s.version     = Sheets::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Bradley J. Spaulding"]
  s.email       = ["brad.spaulding@gmail.com"]
  s.homepage    = "https://github.com/bspaulding/Sheets"
  s.summary     = %q{Sheets provides a Facade for importing spreadsheets that gives the application control. Any Spreadsheet can be represented as either (1) a two dimensional array, or (2) an array of hashes. Sheets' goal is to convert any spreadsheet format to one of these native Ruby data structures.}
  s.description = %q{Work with spreadsheets easily in a native ruby format.}

  s.rubyforge_project = "sheets"

  s.add_dependency('spreadsheet', '>= 0.6.5.2')
  s.add_dependency('rubyzip', '>= 0.9.4')
  s.add_dependency('nokogiri', '>= 1.4.3.1')

  s.add_development_dependency('rake', '0.9.2')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
