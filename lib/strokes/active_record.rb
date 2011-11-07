require 'active_record'
require 'fileutils'

module Strokes
  
  module ActiveRecord
    
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      
      def has_barcode(format, value, versions = {})
        after_create  :create_barcodes
        after_destroy :delete_barcodes

        class_eval <<-RUBY, __FILE__, __LINE__+1
          private
          
          def _barcode_format
            respond_to?(:#{format}, true) ? send(:#{format}) : :#{format}
          end

          def _barcode_value
            send(:#{value})
          end
          
          def _barcode_versions
            #{versions.inspect}
          end
        RUBY
      end
      
    end
    
    def barcode_path
      "#{Rails.root}/barcodes/#{self.class.to_s.tableize}"
    end
    
    def barcode_filename(version = nil)
      filename = version ? "#{id}_#{version}" : "#{id}"
      "#{barcode_path}/#{filename}.png"
    end
    
    def barcode(version = nil)
      File.open(barcode_filename(version))
    end
    
    private
    
    def create_barcodes
      FileUtils.mkdir_p(barcode_path)
      image = Barcode.new(_barcode_format, _barcode_value)
      image.save(barcode_filename)
      _barcode_versions.each do |version, width|
        image.save(barcode_filename(version), :width => width)
      end
    end
    
    def delete_barcodes
      unless id.nil?
        FileUtils.rm(barcode_filename)
        FileUtils.rm(Dir.glob("#{barcode_path}/#{id}_*.png"))
      end
    end
    
  end
  
end
