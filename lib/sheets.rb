module Sheets
  module Parsers; end
  module Renderers; end

  class UnsupportedSpreadsheetFormatError < StandardError; end
end

lib_path = File.expand_path(File.dirname(__FILE__))

# Load Parsers
require File.join lib_path, 'sheets', 'parseable.rb'
require File.join lib_path, 'sheets', 'parsers', 'base.rb'
Dir[ File.join lib_path, 'sheets', 'parsers', '*_parser.rb' ].each {|file| require file }

# Load Renderers
require File.join lib_path, 'sheets', 'renderable.rb'
require File.join lib_path, 'sheets', 'renderers', 'base.rb'
Dir[ File.join lib_path, 'sheets', 'renderers', '*_renderer.rb' ].each {|file| require file }

# Load Sheets::Base
require File.join lib_path, 'sheets', 'base.rb'