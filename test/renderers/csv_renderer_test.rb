class TestCSVRenderer < Test::Unit::TestCase

  def test_to_csv
    renderer = Sheets::Renderers::CSVRenderer.new(example_spreadsheet_data, :csv)

    assert_equal renderer.to_csv, example_spreadsheet_data.collect {|row| row.join(',') }.join("\n")
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
end