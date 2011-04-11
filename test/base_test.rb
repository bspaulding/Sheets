class TestBase < Test::Unit::TestCase
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

  def test_initialize_with_array
    assert_equal EXAMPLE_DATA, Sheets::Base.new( EXAMPLE_DATA ).to_array
  end
end