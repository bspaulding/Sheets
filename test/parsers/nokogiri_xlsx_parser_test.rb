class TestNokogiriXlsxParser < Test::Unit::TestCase
  def test_does_not_raise_error_when_second_workbook_has_id_of_3
    file_path = File.expand_path("../../data/reordered_workbooks.xlsx", __FILE__)
    sheet = Sheets::Parsers::NokogiriXlsxParser.new(File.read(file_path), :xlsx, file_path)
    assert_nothing_raised { sheet.to_array }
  end

  def test_boolean_cell_type
    file_path = File.expand_path("../../data/simple_with_booleans.xlsx", __FILE__)
    sheet = Sheets::Parsers::NokogiriXlsxParser.new(File.read(file_path), :xlsx, file_path)
    assert_equal sheet.to_array, [
      ["Date", "Impressions", "Clicks", "Actions", "Boolean"],
      ["2011-01-01", "10.0", "10.0", "10.0", "TRUE"],
      ["2011-01-02", "10.0", "10.0", "10.0", "TRUE"],
      ["2011-01-03", "10.0", "10.0", "10.0", "FALSE"],
      ["2011-01-04", "10.0", "10.0", "10.0", "FALSE"],
      ["2011-01-05", "10.0", "10.0", "10.0", "TRUE"],
      ["2011-01-06", "10.0", "10.0", "10.0", "TRUE"],
      ["2011-01-07", "10.0", "10.0", "10.0", "FALSE"],
      ["2011-01-08", "10.0", "10.0", "10.0", "FALSE"],
      ["2011-01-09", "10.0", "10.0", "10.0", "TRUE"],
      ["2011-01-10", "10.0", "10.0", "10.0", "TRUE"]
    ]
  end
end
