# encoding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name        = "strokes"
  s.version     = '0.1'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Lars Kuhnt"]
  s.email       = ["lars.kuhnt@gmail.com"]
  s.homepage    = "http://github.com/larskuhnt/strokes"
  s.summary     = "Ruby wrapper for the awsome postscriptbarcode library"
  s.description = "Generates PNG images of barcodes (i.e. EAN13, QR-Code, ISBN)"
 
  s.required_rubygems_version = ">= 1.3.6"
  
  s.add_dependency 'subexec'
  s.add_development_dependency "rspec"
 
  s.files        = Dir.glob("lib/**/*") + %w(LICENSE README.md CHANGELOG.md ROADMAP.md)
  s.require_path = 'lib'
end