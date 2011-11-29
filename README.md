Sheets
==========

Sheets is a Facade on top of many spreadsheet formats, presenting them as simple, unified, native ruby arrays. It is intended to allow applications to easily import data from a wide variety of spreadsheet formats.

With Sheets, all cell values are strings representing the final, evaluated value of the cell. 

This does mean that, in some cases, you will be casting data back into its native format. 

However, this eliminates the need to deal with multiple spreadsheet formats and normalize data types in your application logic.

Your application only needs to care about the layout of the spreadsheet, and the format *you* want the data in.

Usage
----------

Install via Rubygems:

    gem install sheets

To retrieve a list of parseable spreadsheet formats at runtime:

    Sheets::Base.parseable_formats # => ["csv", "xls", "xlsx", "ods"]

To open a spreadsheet, pass initialize Sheets::Base.new either a file path:

    Sheets::Base.new( '/path/to/a/spreadsheet.(format)' )

or a file handle:

    Sheets::Base.new( File.open('/path/to/a/spreadsheet.(format)') )

By default, Sheets will use the basename of the file to detect the spreadsheet type. You can override this by passing in the :format option:

*This is necessary if you pass Sheets an IO object, like StringIO, that doesn't have metadata like a filename/path.*

    Sheets::Base.new( an_io_object_with_spreadsheet_data, :format => :xls )

Once you have imported a sheet, you can either grab the array:

    sheet = Sheets::Base.new( # ... )
    sheet.to_array

or utilize any of the Enumerable functions on the sheet:

    sheet = Sheets::Base.new( # ... )
    sheet.collect {|row| puts row }

Additionally, you may output the sheet in any of the renderable formats:

    Sheets::Base.renderable_formats # => ['csv', 'xls']
    sheet = Sheets::Base.new( file )
    sheet.to_csv
    sheet.to_xls

Sheets::Base will skip the parsing phase if initialized with an array, allowing you to render arrays to a native spreadsheet format:

    my_awesome_data = [ ["Date", "Spent", "Earned"], ["2011-04-11", "$0.00", "$5,000.00"] ]
    sheet = Sheets::Base.new( my_awesome_data )
    sheet.to_csv
    sheet.to_xls

Adding Parsers
------------

Parsers subclass Sheets::Parsers::Base, live in the Sheets::Parsers namespace and should respond to two methods:

* formats: returns an array of string format names (file extensions) that this parser class supports
* to_array: returns a simple array representation of the spreadsheet.

Parsers have access to @data and @format in order to do their parsing. See lib/sheets/parsers/* for examples.

Adding Renderers
------------

Renderers subclass Sheets::Renderers::Base, live in the Sheets::Renderers namespace and should respond to:

* formats: returns an array of string format names that this parser class supports
* to\_#{format}: For each format that a renderer supports, it should respond to "to\_#{format}", returning the file data of that format.

Renderers are given access to the results of Sheets::Base#to_array as @data. See lib/sheets/renderers/* for examples.

Test Suite Results
-----

Sheets uses Travis-CI for Continuous Integration.

[![Build Status](http://travis-ci.org/bspaulding/Sheets.png)](http://travis-ci.org/bspaulding/Sheets)

License
----------

Sheets is licensed under the [MIT License](http://www.opensource.org/licenses/mit-license.php). 

Please note that Sheets is dependent upon the Spreadsheet gem, which is licensed under the [GPLv3](http://www.opensource.org/licenses/gpl-3.0.html).

Credits
----------

Sheets takes advantage of the work done in these gems:

* [spreadsheet](http://rubygems.org/gems/spreadsheet)
* [rubyzip](http://rubygems.org/gems/rubyzip)
* [nokogiri](http://rubygems.org/gems/nokogiri)