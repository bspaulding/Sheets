class TestParseable < Test::Unit::TestCase
  Sheets::Base.parseable_formats.each do |format|
    define_method "test_sheet_parses_#{format}" do
      assert_nothing_raised do
        Sheets::Base.new( File.join('test', 'data', "simple.#{format}") ).to_array
      end
    end
  end
end