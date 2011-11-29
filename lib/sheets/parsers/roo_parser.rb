require 'roo'
require File.join( File.expand_path(File.dirname(__FILE__)), 'roo_patches.rb' )

class Sheets::Parsers::RooParser < Sheets::Parsers::Base
  parses :ods

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
  end

  private
  def spreadsheet
    ROO_CLASS[@format.to_sym].new(@file_path)
  end
end