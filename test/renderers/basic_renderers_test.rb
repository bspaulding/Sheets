renderer_classes = (Sheets::Renderers.constants.map(&:to_s) - ["Base"]).map {|constant_name| Sheets::Renderers.const_get(constant_name) }

test_classes_for_collection renderer_classes do |renderer_class|
  define_method :test_provides_formats do
    assert renderer_class.respond_to? :formats, "#{renderer_class} doesn't respond_to formats."
  end

  define_method :test_formats_not_empty do
    assert !renderer_class.formats.empty?, "#{renderer_class} doesn't render any formats."
  end

  renderer_class.formats.each do |format|
    define_method "test_to_#{format}" do
      renderer = renderer_class.new([], format)
      assert renderer.respond_to?("to_#{format}"), "#{renderer.inspect} doesn't respond to to_#{format}"
    end
  end
end