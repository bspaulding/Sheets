class Sheets::Parsers::Base
  def initialize(data)
    @data = data
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