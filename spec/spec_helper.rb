# encoding: utf-8
ROOT = File.expand_path("../..", __FILE__)
require File.join(ROOT, "lib", "strokes")
require 'logger'
require 'factory_girl'
require_relative 'factories'

module Rails
  def self.root
    '/tmp'
  end
end

def setup_database
  ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => "#{ROOT}/db/scope_filter.db")
  FileUtils.mkdir_p(File.join(ROOT, "log"))
  ActiveRecord::Base.logger = Logger.new(File.open(File.join(ROOT, "log", "test.log"), 'w'))
  ActiveRecord::Base.connection.drop_table(:people) if ActiveRecord::Base.connection.table_exists?(:people)
  ActiveRecord::Base.connection.create_table(:people) do |t|
  end
end