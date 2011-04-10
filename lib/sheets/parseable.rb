module Sheets
  module Parseable
    include Enumerable
    
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def parseable_formats
        Sheets::Parsers.constants.collect {|constant_name| Sheets::Parsers.const_get(constant_name) }.map(&:formats).flatten.uniq
      end
    end

    def each
      to_array.each {|row| yield row }
    end

    def to_array
      parser.send(:to_array)
    end

    private
    def parser_class
      classes = Sheets::Parsers.constants.map do |constant_name|
        constant = Sheets::Parsers.const_get(constant_name)
        constant if constant && constant.respond_to?(:formats) && constant.formats.map(&:to_s).include?(@extension)
      end

      classes.delete(nil)

      classes.first
    end

    def parser
      @parser ||= parser_class.new(@data, @extension, @file_path) unless parser_class.nil?
    end
  end
end