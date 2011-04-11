class TestExcelRenderer < Test::Unit::TestCase

  EXAMPLE_DATA = [
    ["Date", "Impressions", "Clicks", "Actions"],
    ["2011-01-01", "10", "10", "10"],
    ["2011-01-02", "10", "10", "10"],
    ["2011-01-03", "10", "10", "10"],
    ["2011-01-04", "10", "10", "10"],
    ["2011-01-05", "10", "10", "10"],
    ["2011-01-06", "10", "10", "10"],
    ["2011-01-07", "10", "10", "10"],
    ["2011-01-08", "10", "10", "10"],
    ["2011-01-09", "10", "10", "10"],
    ["2011-01-10", "10", "10", "10"]      
  ]

  def test_to_xls
    renderer = Sheets::Renderers::ExcelRenderer.new(EXAMPLE_DATA, :xls)

    file_path = File.expand_path( File.join('test', 'data', "excel_render_test_#{Time.now.to_i}.xls") )
    File.open(file_path, 'w+') {|file| file.write(renderer.to_xls) }

    assert_equal EXAMPLE_DATA, Sheets::Base.new( file_path ).to_array
  ensure
    File.delete( file_path ) if File.exists?( file_path )
  end

  Sheets::Base.parseable_formats.each do |parseable_format|
    define_method "test_#{parseable_format}_to_xls" do
      begin
        sheet = Sheets::Base.new( File.join('test', 'data', "simple.#{parseable_format}") )

        file_path = File.expand_path( File.join('test', 'data', "excel_render_test_#{Time.now.to_i}.xls") )
        File.open(file_path, 'w+') {|file| file.write(sheet.to_xls) }

        assert_equal sheet.to_array, Sheets::Base.new( file_path ).to_array
      ensure  
        File.delete( file_path ) if File.exists?( file_path )
      end
    end
  end
end