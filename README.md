# Strokes

A ruby wrapper of the awesome [postscriptbarcode](http://code.google.com/p/postscriptbarcode/) library.

Note: currently only PNG images are supported.

## External Dependencies

- You need to have [ghostscript](http://www.ghostscript.com/) installed and the `gs` command in your PATH.
- You also need the `mogrify` command in your PATH, which is part of the [imagemagick](http://www.imagemagick.org) library.

## Install

Add it to your Gemfile

```
gem 'strokes'
```

or install the gem directly

```
gem install strokes
```


## Usage

### Using the gem directly

```ruby
require 'strokes'

code = Strokes::Barcode.new(:qrcode, 'http://github.com/larskuhnt/strokes')
code.save('/tmp/test.png')

# if you want to resize the image to a width of 200 pixels
code.save('/tmp/test.png', :width => 200)
```

Barcodes including text will be a bit blurry after resizing
(if you have an idea how to fix that, I will be glad for your input)

### Adding a barcode to your ActiveRecord model

It's as easy as:

```ruby
require 'strokes'
require 'strokes/active_record'

class Barcode < ActiveRecord::Base
  include Strokes::ActiveRecord
  
  has_barcode :isbn, :isbn_number, { :small => 200, :medium => 400 }
  
end
```

It will generate three ISBN barcode images in the directory
`#{Rails.root}/barcodes/#{self.class.to_s.tableize}`,
the original sized image and the specified versions with 200 and 400 pixels width.

The parameters for the `has_barcode` method are:

1. code type: one of the supported code types or a method returning one of them
2. code value: a method returning the value of the code
3. versions: a hash of the versions to create, i.e. `{ :small => 200, :medium => 400 }`


