require 'rubygems'
require 'data_mapper'
require 'dm-migrations'

#DataMapper.setup(:default, 'sqlite://File.dirname(__FILE__)/sets.sqlite')
DataMapper.setup(:default, 'sqlite:///home/barnex/kod/setbot/sets.sqlite')
class LEGOSet
  include DataMapper::Resource
  property :category_id, Integer
  property :category, String
  property :number, String, :key => true
  property :name, String
end

DataMapper.finalize
DataMapper.auto_upgrade!

