require 'spreadsheet'

class Sheets::Parsers::ExcelParser < Sheets::Parsers::Base
  parses :xls

  def to_array
    workbook = Spreadsheet.open(@file_path)
    worksheet = workbook.worksheet(0)
    # worksheet.collect {|row| row.collect {|cell| cell } }
    worksheet.collect do |row|
      cells = []
      row.count.times {|cell_index| cells << row[cell_index].to_s }
      cells
    end
  end
end