class Sheets::Parsers::ExcelParser < Sheets::Parsers::Base
  parses :xls

  def to_array
    workbook = Spreadsheet.open(@file_path)
    worksheet = workbook.worksheet(0)
    worksheet.collect {|row| row.collect {|cell| cell.to_s } }
  end
end