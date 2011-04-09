class TestCSVParser < Test::Unit::TestCase

  def test_to_array
    file_path = generate_test_spreadsheet
    assert_equal Sheets::Base.new( file_path ).to_array, example_spreadsheet_data
  ensure
    File.delete( file_path ) if File.exists?( file_path )
  end

  private
  def example_spreadsheet_data
    [
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
  end
    
  def generate_test_spreadsheet
    filename = "test_simple_#{Time.new.to_i}.csv"
    file_path = File.join('.', filename)

    File.open( file_path, 'w+' ) do |file|
      file.write( example_spreadsheet_data.collect {|row| row.join(',') }.join("\n") )
    end
    
    file_path
  end
end