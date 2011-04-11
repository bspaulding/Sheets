# RubyForge Patch: 28885 - Fixes to Honor XLSX Base Date Format
# NOTE: This fix is *highly* brittle. If roo updates, this may break roo.

class Excelx

  def initialize(filename, packed=nil, file_warning = :error) #, create = false)
    super()
    @file_warning = file_warning
    @tmpdir = "oo_"+$$.to_s
    @tmpdir = File.join(ENV['ROO_TMP'], @tmpdir) if ENV['ROO_TMP'] 
    unless File.exists?(@tmpdir)
      FileUtils::mkdir(@tmpdir)
    end
    filename = open_from_uri(filename) if filename[0,7] == "http://"
    filename = unzip(filename) if packed and packed == :zip
    begin
      file_type_check(filename,'.xlsx','an Excel-xlsx')
      @cells_read = Hash.new
      @filename = filename
      unless File.file?(@filename)
        raise IOError, "file #{@filename} does not exist"
      end
      @@nr += 1
      @file_nr = @@nr
      extract_content(@filename)
      file = File.new(File.join(@tmpdir, @file_nr.to_s+"_roo_workbook.xml"))
      # TODO: @workbook_doc = XML::Parser.io(file).parse
      @workbook_doc = Nokogiri::XML(file)
      
      # Set the base date, could be 1900 or 1904 depending on the system of origin.
      date_base_element = @workbook_doc.search('workbookPr').attribute('date1904')
      if date_base_element && date_base_element.value.to_i == 1
        @base_date = Date.parse('1904-01-01')
      else
        @base_date = Date.parse('1900-01-01')
      end
      @base_datetime = DateTime.parse( @base_date.strftime("%Y-%m-%d") )
      
      file.close
      @shared_table = []
      if File.exist?(File.join(@tmpdir, @file_nr.to_s+'_roo_sharedStrings.xml'))
        file = File.new(File.join(@tmpdir, @file_nr.to_s+'_roo_sharedStrings.xml'))
        #TODO: @sharedstring_doc = XML::Parser.io(file).parse
        @sharedstring_doc = Nokogiri::XML(file)
        file.close
        read_shared_strings(@sharedstring_doc)
      end
      @styles_table = []
      @style_definitions = Array.new # TODO: ??? { |h,k| h[k] = {} }
      if File.exist?(File.join(@tmpdir, @file_nr.to_s+'_roo_styles.xml'))
        file = File.new(File.join(@tmpdir, @file_nr.to_s+'_roo_styles.xml'))
        #TODO: @styles_doc = XML::Parser.io(file).parse
        @styles_doc = Nokogiri::XML(file)
        file.close
        read_styles(@styles_doc)
      end
      @sheet_doc = []
      @sheet_files.each_with_index do |item, i|
        file = File.new(item)
        #TODO: @sheet_doc[i] = XML::Parser.io(file).parse
        @sheet_doc[i] = Nokogiri::XML(file)
        file.close
      end
    ensure
      #if ENV["roo_local"] != "thomas-p"
      FileUtils::rm_r(@tmpdir)
      #end
    end
    @default_sheet = self.sheets.first
    @cell = Hash.new
    @cell_type = Hash.new
    @formula = Hash.new
    @first_row = Hash.new
    @last_row = Hash.new
    @first_column = Hash.new
    @last_column = Hash.new
    @header_line = 1
    @excelx_type = Hash.new
    @excelx_value = Hash.new
    @s_attribute = Hash.new # TODO: ggf. wieder entfernen nur lokal benoetigt
  end

  def set_cell_values(sheet,x,y,i,v,vt,formula,tr,str_v,
      excelx_type=nil,
      excelx_value=nil,
      s_attribute=nil)
    key = [y,x+i]
    @cell_type[sheet] = {} unless @cell_type[sheet]
    @cell_type[sheet][key] = vt
    @formula[sheet] = {} unless @formula[sheet]
    @formula[sheet][key] = formula  if formula
    @cell[sheet]    = {} unless @cell[sheet]
    case @cell_type[sheet][key]
    when :float
      @cell[sheet][key] = v.to_f
    when :string
      @cell[sheet][key] = str_v
    when :date
      @cell[sheet][key] = (@base_date+v.to_i).strftime("%Y-%m-%d")
    when :datetime
      @cell[sheet][key] = (@base_datetime+v.to_f).strftime("%Y-%m-%d %H:%M:%S")
    when :percentage
      @cell[sheet][key] = v.to_f
    when :time
      @cell[sheet][key] = v.to_f*(24*60*60)
    else
      @cell[sheet][key] = v
    end
    @excelx_type[sheet] = {} unless @excelx_type[sheet]
    @excelx_type[sheet][key] = excelx_type
    @excelx_value[sheet] = {} unless @excelx_value[sheet]
    @excelx_value[sheet][key] = excelx_value
    @s_attribute[sheet] = {} unless @s_attribute[sheet]
    @s_attribute[sheet][key] = s_attribute
  end
end