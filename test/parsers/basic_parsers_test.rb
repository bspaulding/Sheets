parser_classes = (Sheets::Parsers.constants.map(&:to_s) - ["Base"]).map {|constant_name| Sheets::Parsers.const_get(constant_name) }

test_classes_for_collection parser_classes do |parser_class|
  define_method :test_provides_formats do
    assert parser_class.respond_to? :formats, "#{parser_class} doesn't respond_to formats."
  end

  define_method :test_formats_not_empty do
    assert !parser_class.formats.empty?, "#{parser_class} doesn't render any formats."
  end

  parser_class.formats.each do |format|
    define_method "test_#{format}_responds_to_to_array" do
      parser = parser_class.new([], format, nil)
      assert parser.respond_to?("to_array"), "#{parser.inspect} doesn't respond to to_array"
    end

    define_method "test_#{format}_to_array_matches_sample_data" do
      example_data = [
        [ "Date",       "Impressions", "Clicks", "Actions" ],
        [ "2011-01-01", "10.0",        "10.0",   "10.0"    ],
        [ "2011-01-02", "10.0",        "10.0",   "10.0"    ],
        [ "2011-01-03", "10.0",        "10.0",   "10.0"    ],
        [ "2011-01-04", "10.0",        "10.0",   "10.0"    ],
        [ "2011-01-05", "10.0",        "10.0",   "10.0"    ],
        [ "2011-01-06", "10.0",        "10.0",   "10.0"    ],
        [ "2011-01-07", "10.0",        "10.0",   "10.0"    ],
        [ "2011-01-08", "10.0",        "10.0",   "10.0"    ],
        [ "2011-01-09", "10.0",        "10.0",   "10.0"    ],
        [ "2011-01-10", "10.0",        "10.0",   "10.0"    ]
      ]

      file_path = File.expand_path( File.join('test', 'data', "simple.#{format}") )
      parser = parser_class.new( File.read(file_path), format, file_path )
      result = parser.to_array

      # Normalize to parsed dates to avoid Date type conflict 'failures'
      result[1..-1].collect {|row| row[0] = Date.parse(row[0]).strftime('%Y-%m-%d') }

      assert_equal example_data, result, "#{parser_class}#to_array for format #{format} doesn't match example data."
    end
  end
end