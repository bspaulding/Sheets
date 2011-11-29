require 'nokogiri'
require 'zip/zip'

class Sheets::Parsers::NokogiriXlsxParser < Sheets::Parsers::Base
  parses :xlsx

  def to_array
    # Create Matrices
    matrices = worksheets.collect do |worksheet|
      worksheet.css('sheetData>row').collect do |row|
        row.css('c').collect do |cell|
          cell_value = cell.css('v').text

          if cell.attribute('t')
            celltype = cell.attribute('t').value
            if celltype == 's'
              # Load Shared String Value
              cell_value = shared_strings[cell_value.to_i]
            elsif celltype == 'b'
              cell_value = (cell_value == "1") ? "TRUE" : "FALSE"
            end
          end
          
          if cell.attribute('s') && cell.attribute('s').value == "1"
            cell_value = (base_date + cell_value.to_f).strftime('%Y-%m-%d') # Date conversion
          end

          if cell_value.match(/\A[0-9]+\.?[0-9]*\Z/)
            cell_value = cell_value.to_f.to_s
          end

          cell_value
        end
      end
    end

    matrices.first
  end

  private

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

  # returns an array of strings containing the worksheet ids from the workbook
  def worksheet_ids
    @sheet_ids ||= workbook.css('sheets>sheet').collect {|sheet| sheet.attribute('sheetId').value }
  end

  # returns an array of nokogiri documents for each worksheet
  def worksheets
    @worksheets ||= worksheet_ids.collect {|sheet_id| Nokogiri::XML( zipfile.read("xl/worksheets/sheet#{sheet_id}.xml") ) }
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