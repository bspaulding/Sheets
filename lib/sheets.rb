module Sheets
  module Parsers
  end

  class UnsupportedSpreadsheetFormatError < StandardError; end
end

require File.join 'lib', 'sheets', 'parseable.rb'
require File.join 'lib', 'sheets', 'parsers', 'base.rb'
Dir[ File.join 'lib', 'sheets', 'parsers', '*_parser.rb' ].each {|file| require file }

require File.join 'lib', 'sheets', 'base.rb'