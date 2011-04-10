class Sheets::Parsers::Base
  def initialize(data, format, file_path)
    @data = data
    @format = format
    @file_path = file_path
  end

  def io
    StringIO.new(@data)
  end

  def self.parses(*args)
    self.formats = args.map(&:to_s)
  end

  def self.formats
    @formats ||= []
  end

  def self.formats=(new_formats)
    @formats = new_formats
  end
end