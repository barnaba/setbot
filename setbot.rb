#!/usr/bin/ruby1.9.1

require 'cinch'
require 'open-uri'
require 'nokogiri'
require 'cgi'
require 'iconv'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.quakenet.org"
    c.nick = "__setbot__"
    c.channels = ["#lugpol"]
  end

  helpers do
    # Extremely basic method, grabs the first result returned by Google
    # or "No results found" otherwise
    def getset(query)
      returl = "http://www.bricklink.com/catalogList.asp?catType=&catID=&itemYear=&searchNo=Y&q=#{query}&catLike=W"
      query.gsub!("-","_")
      url = "http://guide.lugnet.com/set/#{query}"
      res = Nokogiri::HTML(open(url)).at("b")
      title = res.text
    rescue
      "nie znaleziono #{query}, ale i tak sprawdz #{returl}"
    else
      Iconv.conv('ASCII//IGNORE', 'UTF8', CGI.unescape_html(title)) + " ( " + returl + " )"
    end
  end

  on :message, /(^\d{3,}(?:-\d+)?$)/ do |m, query|
    m.reply getset(query)
  end

  on :message, /^ping$/ do |m, query|
    unless m.channel?
      m.reply "Pong!"
    end
  end

  on :message, /@(\d+(-\d+)?)/ do |m, query|
    m.reply getset(query)
  end

  on :message, /!help/ do |m|
    m.reply "Informacje o zestawach - @<numer zestawu> w wiadomosci, lub tylko <numer zestawu> dla numerow powyzej 4 cyfr"
  end
end

bot.start


