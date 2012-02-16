# encoding: UTF-8
#

require 'rubygems'
require 'bundler/setup'
require 'yaml'

Bundler.require

require File.dirname(__FILE__) + '/legoset'

bot = Cinch::Bot.new do

  configure do |c|
    c.server = "irc.quakenet.org"
    c.nick = "__setbot__"
    c.channels = ["#lugpol"]
  end


  @setinfo = lambda do |m, set_number|
    sets = getset(set_number)
    if sets.empty?
      m.reply "Nie znalazlem zestawu \002#{set_number}"
      return
    end

    reply = sets.map do |set|
      "#{set.number}: \002#{set.name}\002"
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
      @settings ||= YAML::load_file File.dirname(__FILE__) + "/settings.yml" 
      url =  "http://www.bricklink.com/catalogList.asp?catType=&catID=&itemYear=&searchNo=Y&q=#{set.number}&catLike=W"
      Bitly.shorten(url, @settings['bitly']['user'], @settings['bitly']['key']).url
    end
  end


  on :message, /(?:[@]|zestaw\s*)(\d{2,}(?:-\d+)?)/i, &@setinfo
  on :message, /^(\d+(?:-\d+)?)\??$/i, &@setinfo

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


  on :message, /^!ogonki (.+)/ do |m, ogonki|
    reply = ogonki.gsub /([żółćęśąźńŻÓŁĆĘŚĄŹŃ])/, "\00303\\1\003"
    m.reply "Znalazłem następujące ogonki: #{reply}"
  end

  on :message, /^!spell (.+)/ do |m, line|
      @speller ||= Aspell.new("pl_PL")
      @speller.suggestion_mode = Aspell::NORMAL
      words = line.split(" ")
      words = words.map do |word|
        @speller.check(word) ? word : "\00304#{word}\003"
      end
      m.reply words.join(" ")

  end

  on :message, /zażółć gęślą jaźń/ do |m|
    m.reply "zażółć gęślą jaźń" unless m.params.last =~ /!ogonki/
  end

end

bot.start
