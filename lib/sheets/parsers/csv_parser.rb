require 'csv'

class Sheets::Parsers::CSVParser < Sheets::Parsers::Base
  parses :csv

  def to_array
    CSV.parse( @data )
  end
end