require 'rubygems'
require 'cinch'
require 'ruby-debug'
require 'nokogiri'
require 'open-uri'
require 'ruby-bitly'
require 'yaml'

require File.dirname(__FILE__) + '/legoset'

bot = Cinch::Bot.new do

  configure do |c|
    c.server = "irc.quakenet.org"
    c.nick = "__setbot__"
    c.channels = ["#lugpoll"]
  end


  @setinfo = lambda do |m, set_number|
    sets = getset(set_number)
    reply = sets.map do |set|
      "#{set.number}: #{set.name}"
    end
    pad = reply.max { |a,b| a.length <=> b.length }
    reply.each_with_index do |r, index|
      m.reply r.ljust(pad.length+1) + bl_formatter(sets[index])
    end
  end


  helpers do
    def getset(query)
      return (LEGOSet.all(:number => query) + LEGOSet.all(:number.like => query + '-%'))
    end

    def bl_formatter(set)
      puts @settings.inspect
      @settings ||= YAML::load_file File.dirname(__FILE__) + "/settings.yml" 
      url =  "http://www.bricklink.com/catalogList.asp?catType=&catID=&itemYear=&searchNo=Y&q=#{set.number}&catLike=W"
      Bitly.shorten(url, @settings['bitly']['user'], @settings['bitly']['key']).url
    end


  on :message, /(?:[@%&#!]|zestaw\s*)(\d{2,}(?:-\d+)?)/, &@setinfo
  on :message, /^(\d+(?:-\d+)?)\??$/, &@setinfo

  on :message, /^ping$/ do |m, query|
    unless m.channel?
      m.reply "Pong!"
    end
  end

  on :message, /!help|!pomoc|!setbot/ do |m|
    m.reply "Informacje o setbocie: http://github.com/barnaba/setbot"
  end

  on :message, /!baza/ do |m|
    data = File.open("dbversion", "r").read.chomp
    m.reply "Baza ostatnio uaktualniana #{data}. Baza zawiera #{LEGOSet.count} rekordow."
  end


  on :join do |m|
    nick = m.user.nick
    if nick != "" and User.count(:nick => nick) == 0

      user = User.new
      user.nick = nick
      user.save!

      m.reply "#{nick}: YO MAN OBCZAJ NOWEGO SETBOTA YEAH http://github.com/barnaba/setbot"
    end
  end

end

bot.start

