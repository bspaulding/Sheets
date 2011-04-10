class TestRenderable < Test::Unit::TestCase
  Sheets::Base.renderable_formats.each do |renderable_format|
    define_method "test_sheet_responds_to_#{renderable_format}" do
      sheet = Sheets::Base.new( File.join('test', 'data', 'simple.csv') )
      assert_nothing_raised { sheet.send("to_#{renderable_format}") }
    end
  end
end