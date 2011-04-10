parser_classes = (Sheets::Parsers.constants - ["Base"]).map {|constant_name| Sheets::Parsers.const_get(constant_name) }

test_classes_for_collection parser_classes do |parser_class|
  define_method :test_provides_formats do
    assert parser_class.respond_to? :formats, "#{parser_class} doesn't respond_to formats."
  end

  define_method :test_formats_not_empty do
    assert !parser_class.formats.empty?, "#{parser_class} doesn't render any formats."
  end

  parser_class.formats.each do |format|
    define_method "test_#{format}_to_array" do
      parser = parser_class.new([], format, nil)
      assert parser.respond_to?("to_array"), "#{parser.inspect} doesn't respond to to_array"
    end
  end
end