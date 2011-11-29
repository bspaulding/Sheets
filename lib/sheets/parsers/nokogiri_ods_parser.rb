require 'nokogiri'
require 'zip/zip'

class Sheets::Parsers::NokogiriOdsParser < Sheets::Parsers::Base
  parses :ods

  def to_array
    rows.collect do |row| 
      table_cells = []
      row.xpath('table:table-cell').each do |cell|
        repeat = cell.attributes["number-columns-repeated"].text.to_i if cell.attributes["number-columns-repeated"]
        repeat ||= 1
        repeat.times { table_cells << cell }
      end

      table_cells.collect {|cell| value_for_cell(cell) }
    end
  end

  private

  # returns the zipfile object for the document
  def zipfile
    @zipfile ||= Zip::ZipFile.open( @file_path )
  end

  def content_doc
    @content_doc ||= Nokogiri::XML( zipfile.read('content.xml') )
  end

  def rows
    @rows ||= content_doc.xpath('//table:table/table:table-row')
  end

  def value_for_cell(cell_element)
    value_type = cell_element.attributes["value-type"]
    send("#{value_type}_value_for_cell", cell_element)
  end

  def string_value_for_cell(cell_element)
    cell_element.xpath('text:p').text
  end

  def float_value_for_cell(cell_element)
    cell_element.xpath('text:p').text.to_f.to_s
  end
end