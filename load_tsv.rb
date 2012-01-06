require File.dirname(__FILE__) + '/legoset'

ARGF.each do |line|
  category_id, category, number, name = line.split("\t")
  set = LEGOSet.create(
    :category_id => category_id,
    :category => category,
    :number => number,
    :name => name
  )
  set.save
end
