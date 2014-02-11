require 'nokogiri'
require 'zip/zip'

class Sheets::Parsers::NokogiriXlsxParser < Sheets::Parsers::Base
  parses :xlsx

  def to_array
    extract_worksheet(worksheets.first)
  end

  private

  def extract_worksheet(worksheet)
    worksheet.css('sheetData>row').collect {|row| extract_row(row) }
  end

  def extract_row(row)
    row.css('c').collect {|cell| value_for_cell(cell) }
  end

  def value_for_cell(cell)
    cell_value = value_for_cell_type(cell.css('v').text, cell_type(cell))

    if cell.attribute('s') && cell.attribute('s').value == "1"
      cell_value = (base_date + cell_value.to_f).strftime('%Y-%m-%d') # Date conversion
    end

    if cell_value.match(/\A[0-9]+\.?[0-9]*\Z/)
      cell_value = cell_value.to_f.to_s
    end

    cell_value
  end

  def cell_type(cell)
    cell.attribute('t') ? cell.attribute('t').text : nil
  end

  def value_for_cell_type(cell_value, type)
    { 's' => shared_strings[cell_value.to_i],
      'b' => ((cell_value == "1") ? "TRUE" : "FALSE")
    }[type] || cell_value
  end

  # returns the zipfile object for the document
  def zipfile
    @zipfile ||= Zip::ZipFile.open( @file_path )
  end

  # returns a nokogiri document for the workbook
  def workbook
    @workbook ||= Nokogiri::XML( zipfile.read("xl/workbook.xml") )
  end

  # returns an array of strings for the sharedStrings.
  def shared_strings
    @shared_strings ||= Nokogiri::XML( zipfile.read("xl/sharedStrings.xml") ).css('si>t').collect(&:text)
  end

  def number_of_worksheets
    @number_of_worksheets ||= workbook.css("sheets > sheet").size
  end

  # returns an array of nokogiri documents for each worksheet
  def worksheets
    @worksheets ||= (1..number_of_worksheets).collect { |n| Nokogiri::XML(zipfile.read("xl/worksheets/sheet#{n}.xml")) }
  end

  # returns a date object representing the start of the serial date system for this sheet
  # Either 1900-01-01 or 1904-01-01
  def base_date
    @base_date ||= lambda do
      date_base_element = workbook.search('workbookPr').attribute('date1904')
      if date_base_element && date_base_element.value.to_i == 1
        Date.parse('1904-01-01')
      else
        Date.parse('1900-01-01')
      end
    end.call
  end
end
