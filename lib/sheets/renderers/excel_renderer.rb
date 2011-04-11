class Sheets::Renderers::ExcelRenderer < Sheets::Renderers::Base
  renders :xls

  def to_xls
    workbook = Spreadsheet::Excel::Workbook.new
    worksheet = Spreadsheet::Excel::Worksheet.new
    workbook.add_worksheet(worksheet)

    @data.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        worksheet[row_index, col_index] = cell
      end
    end

    # Tried to use StringIO here, but ran into encoding issues with Ruby 1.8.7. 
    file_path = "tmp_excel_render_#{Time.now.to_i}"
    File.open(file_path, 'w+') {|file| workbook.write(file) }
    File.read(file_path)
  ensure
    File.delete( file_path ) if File.exists?( file_path )
  end
end