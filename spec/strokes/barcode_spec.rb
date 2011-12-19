require 'spec_helper'

include Strokes

describe Barcode do
  
  before do
    @filename = '/tmp/test.png'
  end
  
  it "should generate a qrcode png file" do
    Barcode.new(:qrcode, 'http://stampr.de#12345678').save(@filename)
    lambda { File.unlink(@filename) }.should_not raise_error 
  end
  
  it "should generate a upca png file" do
    Barcode.new(:upca, '012345678905').save(@filename)
    lambda { File.unlink(@filename) }.should_not raise_error
  end
  
  it "should generate a upce png file" do
    Barcode.new(:upce, '1234567').save(@filename)
    lambda { File.unlink(@filename) }.should_not raise_error
  end
  
  it "should generate a isbn png file" do
    Barcode.new(:isbn, '1-86074-271-2').save(@filename)
    lambda { File.unlink(@filename) }.should_not raise_error
  end
  
  it "should generate a ean8 png file" do
    Barcode.new(:ean8, '01335583').save(@filename)
    lambda { File.unlink(@filename) }.should_not raise_error
  end
  
  it "should generate a ean13 png file" do
    Barcode.new(:ean13, '9771473968012').save(@filename)
    lambda { File.unlink(@filename) }.should_not raise_error
  end
  
  it "should generate a code39 png file" do
    Barcode.new(:code39, 'CODE39').save(@filename)
    lambda { File.unlink(@filename) }.should_not raise_error
  end
  
  it "should generate a code128 png file" do
    Barcode.new(:code128, 'Count0123456789!').save(@filename)
    lambda { File.unlink(@filename) }.should_not raise_error
  end
  
  it "should generate a itf png file" do
    Barcode.new(:itf, '0003355865001207').save(@filename)
    lambda { File.unlink(@filename) }.should_not raise_error
  end
  
end

