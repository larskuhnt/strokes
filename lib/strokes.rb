# encoding: utf-8
require 'strokes/barcode'

module Strokes
  
  class IllegalSymbolError < StandardError; end
  class GhostScriptError < StandardError; end
  class ImageMagickError < StandardError; end
  
end
