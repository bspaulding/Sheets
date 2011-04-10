class Sheets::Renderers::Base
  def initialize(data, format)
    @data = data
    @format = format
  end

  def self.renders(*args)
    self.formats = args.map(&:to_s)
  end

  def self.formats
    @formats ||= []
  end

  def self.formats=(new_formats)
    @formats = new_formats
  end
end