require 'subexec'

module Strokes
  
  VALID_SYMBOLS = [:qrcode, :code39, :code128, :ean8, :ean13, :isbn, :upca, :upce]
    
  class Barcode
  
    def initialize(symbol, content, options = '')
      raise IllegalSymbolError, symbol.to_s unless VALID_SYMBOLS.include?(symbol.to_sym)
      @symbol = symbol.to_sym
      @content = content
      @options = options
    end
  
    # filename should include the full path
    # options:
    #  - width: width of the resulting png
    def save(filename, options = {})
      ps = send(@symbol)
      gs_options = [
        "-dBATCH", "-dNOPAUSE", "-q", "-dTextAlphaBits=4", "-dSAFER",
        "-sOutputFile=#{filename}",
        "-sDEVICE=pnggray"
      ]
      barcode_ps = "#{File.expand_path(File.dirname(__FILE__))}/barcode.ps"
      sub = Subexec.run "gs #{gs_options.join(" ")} #{barcode_ps} -c '#{ps}'"
      raise(GhostScriptError, sub.output) unless sub.exitstatus == 0
      resize_method = (ps =~ /includetext/ ? "-scale" : "-sample")
      im_options = [
        "-trim",
        "-bordercolor white",
        "-border 10%",
        options[:width] ? "#{resize_method} #{options[:width]}" : nil
      ].compact
      sub = Subexec.run "mogrify #{im_options.join(' ')} #{filename}"
      raise(ImageMagickError, sub.output) unless sub.exitstatus == 0
      File.open(filename, 'r')
    end
  
    private
  
    def ps_commands(code_options, options = {})
    <<-PS
      <</Orientation 1>> setpagedevice
      #{options[:translate] || '100 680'} translate
      #{options[:rotate] || '-90'} rotate
      #{options[:scale] || '6 6'} scale
      0 0 moveto (#{@content}) (#{code_options.join(' ')}) /#{@symbol} /uk.co.terryburton.bwipp findresource exec
      showpage
    PS
    end
  
    def qrcode
      ps_commands([@options], :translate => '0 750', :scale => '8 8')
    end
  
    def upca
      ps_commands(['includetext', @options])
    end
  
    def upce
      ps_commands(['includetext', @options])
    end
  
    def isbn
      ps_commands(['includetext', 'guardwhitespace', @options])
    end
  
    def ean8
      ps_commands(['includetext', 'guardwhitespace', @options])
    end
  
    def ean13
      ps_commands(['includetext', 'guardwhitespace', @options])
    end
  
    def code39
      ps_commands(['includetext', @options], :scale => '5 5')
    end
  
    def code128
      ps_commands(['includetext', @options], :scale => '4 4', :translate => '150 750')
    end
  
  end

end
