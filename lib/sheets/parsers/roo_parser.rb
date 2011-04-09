require 'roo'

class Sheets::Parsers::RooParser < Sheets::Parsers::Base
  parses :xls, :xlsx, :ods

  ROO_CLASS = {
    :xls  => Excel,
    :xlsx => Excelx,
    :ods  => Openoffice
  }

  def to_array
    array = []
    (spreadsheet.first_row..spreadsheet.last_row).each do |row_num|
      row = []
      (spreadsheet.first_column..spreadsheet.last_column).each do |column_num|
        row << spreadsheet.cell(row_num, column_num).to_s
      end
      array << row
    end
    array
  ensure
    File.delete(@file_path) if File.exists?(@file_path)
  end

  def to_csv
    spreadsheet.to_csv
  ensure
    File.delete(@file_path) if File.exists?(@file_path)
  end

  private
  def spreadsheet
    @file_path = "tmp_#{Time.now.to_i}.#{@format}"
    File.open(@file_path, 'w+') {|f| f.write(@data) }
    ROO_CLASS[@format.to_sym].new(@file_path)
  end
end