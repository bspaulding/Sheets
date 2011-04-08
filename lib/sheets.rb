require 'parsable'
require Dir[ File.join 'parsers', '*.rb' ]

module Sheets
  class Base
    include Parsable

    def initialize(file)

    end
  end
end
