module Sheets::Parseable
  include Enumerable
  
  def each
    to_array.each {|row| yield row }
  end

  [ :to_array, :to_csv ].each do |method_name|
    define_method(method_name) do
      parser.send(method_name)
    end
  end


  def parser
    @parser ||= Sheets::Parsers.constants.select {|constant| constant.respond_to? :formats && constant.formats.include? @extension }.first
  end
end