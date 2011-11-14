require 'spec_helper'
require 'strokes/active_record'

setup_database

class Person < ActiveRecord::Base
  
  include Strokes::ActiveRecord
  
  has_barcode :code_type, :code_value, { :thumb => 200 }
  
  def code_type
    :qrcode
  end
  
  def code_value
    "http://www.barcode.test/123456"
  end
  
end

describe ActiveRecord do
  
  before do
    @model = Factory(:person)
  end
  
  after(:all) do
    FileUtils.rm_rf(Person.new.barcode_path)
  end
  
  describe "#save" do
    
    it "should create the barcode" do
      @model.save
      File.exists?(@model.barcode_filename).should be_true
    end
    
    it "should create the thumb version of the barcode" do
      @model.save
      File.exists?(@model.barcode_filename(:thumb)).should be_true
    end
    
  end
  
  describe "#destroy" do
    
    before do
      @model.save
    end
    
    it "should delete the barcode" do
      @model.destroy
      File.exists?(@model.barcode_filename).should be_false
    end
    
    it "should delete the thumb version of the barcode" do
      @model.destroy
      File.exists?(@model.barcode_filename(:thumb)).should be_false
    end
    
    it "should not delete the barcodes of other models" do
      @model1 = Factory(:person)
      @model1.save
      @model.destroy
      File.exists?(@model1.barcode_filename).should be_true
    end
    
    it "should not delete the barcodes of models with the same first character" do
      @model1 = Factory(:person, :id => @model.id*100)
      @model1.save
      @model.destroy
      File.exists?(@model1.barcode_filename).should be_true
    end
    
    it "should not delete any barcodes if the id is nil" do
      filename = @model.barcode_filename
      @model.id = nil
      @model.destroy
      File.exists?(filename).should be_true
    end
    
  end
  
end