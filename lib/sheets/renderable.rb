module Sheets
  module Renderable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def renderable_formats
        Sheets::Renderers.constants.collect {|constant_name| Sheets::Renderers.const_get(constant_name) }.map(&:formats).flatten.uniq
      end
    end

    def method_missing(method_name, *args, &block)
      match = method_name.to_s.match(/\Ato_(.*)/i)
      format = match[1] unless match.nil?
      
      format.nil? || !self.class.renderable_formats.include?(format) ? super(method_name, args, block) : renderer(format).send(method_name)
    end

    private
    def renderer_class(format)
      classes = Sheets::Renderers.constants.map do |constant_name|
        constant = Sheets::Renderers.const_get(constant_name)
        constant if constant && constant.respond_to?(:formats) && constant.formats.map(&:to_s).include?(format)
      end

      classes.delete(nil)

      classes.first      
    end

    def renderer(format = @extension)
      renderer_class(format).new(to_array, format) unless renderer_class(format).nil?
    end
  end
end