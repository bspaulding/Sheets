class TestRooParser < Test::Unit::TestCase
  
  def test_roo_date_format_issue
    sheet = Sheets::Base.new( 'test/data/roo_issue_28885_test.xlsx' )

    assert_equal "2011-01-10", sheet.to_array[1][0]
  end
end