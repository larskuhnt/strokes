# encoding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name        = "strokes"
  s.version     = '0.9.2'
  s.platform    = Gem::Platform::RUBY
  s.date        = Time.now.to_date.to_s
  s.authors     = ["Lars Kuhnt"]
  s.email       = ["lars.kuhnt@gmail.com"]
  s.homepage    = "http://github.com/larskuhnt/strokes"
  s.summary     = "Ruby wrapper for the awesome postscriptbarcode library"
  s.description = "Generates PNG images of barcodes. Currently supports EAN8, EAN13, QR-Code, ISBN, CODE39, CODE128, UPCA, UPCE, ITF"
 
  s.required_rubygems_version = ">= 1.3.6"
  
  s.add_dependency 'subexec'
  s.add_development_dependency "rspec"
  s.add_development_dependency "sqlite3"
  
 
  s.files        = Dir.glob("lib/**/*") + %w(LICENSE README.md CHANGELOG.md ROADMAP.md)
  s.require_path = 'lib'
end
