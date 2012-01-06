require 'rubygems'
require 'mechanize'

a = Mechanize.new
sets = ""
a.get('http://www.bricklink.com/catalogDownload.asp') do |page|
  sets = page.form_with(:action => 'catalogDownload.asp?a=a') do |f|
  end.click_button
end
puts sets.inspect
