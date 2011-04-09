Sheets
==========

Sheets is a Facade on top of many spreadsheet formats, presenting them as simple, unified, native ruby arrays. It is intended to allow applications to easily import data from a wide variety of spreadsheet formats.

With Sheets, all cell values are strings representing the final, evaluated value of the cell. 

This does mean that, in some cases, you will be casting data back into its native format. 

However, this eliminates the need to deal with multiple spreadsheet formats and normalize data types in your application logic.

Your application only needs to care about the layout of the spreadsheet, and the format *you* want the data in.

Usage
----------

To retrieve a list of supported spreadsheet formats at runtime:

    Sheets::Base.formats # => ["csv", "xls", "xlsx", "ods"]

To open a spreadsheet, pass initialize Sheets::Base.new either a file path:

    Sheets::Base.new( '/path/to/a/spreadsheet.(format)' )

or a file handle:

    Sheets::Base.new( File.open('/path/to/a/spreadsheet.(format)') )

By default, Sheets will use the basename of the file to detect the spreadsheet type. You can override this by passing in the :format option:

    Sheets::Base.new( File.open('/path/to/a/spreadsheet.(format)'), :format => :xls )

Once you have imported a sheet, you can either grab the array:

    sheet = Sheets::Base.new( # ... )
    sheet.to_array

or utilize any of the Enumerable functions on the sheet:

    sheet = Sheets::Base.new( # ... )
    sheet.collect {|row| puts row }

Adding Parsers
------------

Parsers subclass Sheets::Parsers::Base, live in the Sheets::Parsers namespace and should respond to two methods:

* formats: returns an array of string format names (file extensions) that this parser class supports
* to_array: returns a simple array representation of the spreadsheet.

Parsers have access to @data and @format in order to do their parsing. See lib/sheets/parsers/* for examples.