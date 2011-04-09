module Sheets
  class Base
    include Parseable

    def initialize(file)
      file = File.open(file.to_s) unless file.respond_to? :read
      
      @data = file.read
      @extension = File.basename(file.path).split('.')[-1]

      # raise UnsupportedSpreadsheetFormatError, "Couldn't find a parser for the '#{@extension}' format." if parser.nil?
    end
  end
end