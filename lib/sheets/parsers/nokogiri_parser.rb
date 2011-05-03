class Sheets::Parsers::NokogiriParser < Sheets::Parsers::Base
  parses :xlsx

  def to_array
    # Create Matrices
    matrices = worksheets.collect do |worksheet|
      worksheet.css('sheetData>row').collect do |row|
        row.css('c').collect do |cell|
          cell_value = cell.css('v').text

          if cell.attribute('t') && cell.attribute('t').value == 's'
            # Load Shared String Value
            cell_value = shared_strings[cell_value.to_i]
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
end