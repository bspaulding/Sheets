module Sheets
  module Parsers; end
  module Renderers; end

  class UnsupportedSpreadsheetFormatError < StandardError; end
end

# Load Parsers
require File.join 'lib', 'sheets', 'parseable.rb'
require File.join 'lib', 'sheets', 'parsers', 'base.rb'
Dir[ File.join 'lib', 'sheets', 'parsers', '*_parser.rb' ].each {|file| require file }

# Load Renderers
require File.join 'lib', 'sheets', 'renderable.rb'
require File.join 'lib', 'sheets', 'renderers', 'base.rb'
Dir[ File.join 'lib', 'sheets', 'renderers', '*_renderer.rb' ].each {|file| require file }

# Load Sheets::Base
require File.join 'lib', 'sheets', 'base.rb'