module Sheets
  module Parsers
  end

  class UnsupportedSpreadsheetFormatError < StandardError; end
end

require File.join 'lib', 'sheets', 'parseable.rb'
Dir[ File.join 'parsers', '*.rb' ].each {|file| require file }

require File.join 'lib', 'sheets', 'base.rb'