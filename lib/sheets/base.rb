module Sheets
  class Base
    include Parseable
    include Renderable

    def initialize(file, options = {})
      file = File.open(file.to_s) unless file.respond_to? :read
      options[:format] ||= File.basename(file.path).split('.')[-1]
      
      @data = file.read
      @extension = options[:format].to_s
      @file_path = File.expand_path(file.path)

      raise UnsupportedSpreadsheetFormatError, "Couldn't find a parser for the '#{@extension}' format." if parser.nil?
    end
  end
end