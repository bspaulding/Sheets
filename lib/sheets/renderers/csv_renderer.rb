class Sheets::Renderers::CSVRenderer < Sheets::Renderers::Base
  renders :csv

  def to_csv
    @data.collect {|row| row.join(',') }.join("\n")
  end
end