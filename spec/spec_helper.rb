# encoding: utf-8
ROOT = File.expand_path("../..", __FILE__)
require File.join(ROOT, "lib", "strokes")

include Strokes

module Rails
  def self.root
    File.join(ROOT, 'tmp')
  end
end
