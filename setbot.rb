#!/usr/bin/ruby1.9.1

require 'cinch'
require 'open-uri'
require 'nokogiri'
require 'cgi'
require 'iconv'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.quakenet.org"
    c.nick = "setbot"
    c.channels = ["#lugpol"]
  end

  helpers do
    # Extremely basic method, grabs the first result returned by Google
    # or "No results found" otherwise
    def getset(query)
      returl = "http://www.bricklink.com/catalogList.asp?catType=&catID=&itemYear=&searchNo=Y&q=#{query}&catLike=W"
      url = "http://guide.lugnet.com/set/#{query}"
      res = Nokogiri::HTML(open(url)).at("b")
      title = res.text
    rescue
      ""
    else
      Iconv.conv('ASCII//IGNORE', 'UTF8', CGI.unescape_html(title)) + " ( " + returl + " )"
    end
  end

  on :message, /(\d{4,})/ do |m, query|
    m.reply getset(query)
  end
end

bot.start


