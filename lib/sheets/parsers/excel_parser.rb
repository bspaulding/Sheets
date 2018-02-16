require 'ole/base'

class Sheets::Parsers::ExcelParser < Sheets::Parsers::Base
  parses :xls

  def to_array
    worksheet.collect do |row|
      cells = []
      row.count.times {|cell_index| cells << row[cell_index].to_s }
      cells
    end
  end

  private

  def worksheet
    workbook.worksheet(0)
  end

  def workbook
    @workbook ||= lambda {
      raise "No 'Workbook' entry found in ole document" unless ole.dir.entries('.').include?("Workbook")

      ole.file.read('Workbook')
    }.call
  end

  def ole
    @ole ||= Ole::Storage.open(@file_path, 'rb+')
  end
end
