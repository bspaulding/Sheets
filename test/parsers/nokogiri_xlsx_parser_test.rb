class TestNokogiriXlsxParser < Test::Unit::TestCase
  def setup
    file_path = File.expand_path("../../data/reordered_workbooks.xlsx", __FILE__)
    @sheet = Sheets::Parsers::NokogiriXlsxParser.new(File.read(file_path), :xlsx, file_path)
  end

  def test_does_not_raise_error_when_second_workbook_has_id_of_3
    assert_nothing_raised { @sheet.to_array }
  end
end
