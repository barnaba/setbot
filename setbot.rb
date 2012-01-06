require 'rubygems'
require 'cinch'
require 'ruby-debug'
require File.dirname(__FILE__) + '/legoset'


bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.quakenet.org"
    c.nick = "__setbot__"
    c.channels = ["#lugpol"]
  end

  helpers do
    def getset(query)
      return (LEGOSet.all(:number => query) + LEGOSet.all(:number.like => query + '-%'))
    end

    def to_s_formatter(set)
      "#{set.name}"
    end

    def long_formatter(set)
      "#{set.category} >> #{set.name}"
    end

    def bl_formatter(set)
      "http://www.bricklink.com/catalogList.asp?catType=&catID=&itemYear=&searchNo=Y&q=#{set.number}&catLike=W"
    end

    def n_formatter(set)
      "#{set.number}"
    end

    def bs_formatter(set)
      "http://brickset.com/detail/?Set=#{set.number}"
    end
  end

  on :message, /@(\d{2,}(?:-\d+)?)([=+])?(\w+)?/ do |m, set_number, operator, formatter|
    sets = getset(set_number)
    operator ||= "="
    formatter ||= "to_s"
    formatter += "_formatter"
    formatter_sym = formatter.to_sym

    puts "GOT QUERY LOL"
    puts "set number #{set_number}"
    puts "formater #{formatter}"

    unless respond_to? formatter_sym
      formatter_sym = :to_s_formatter
    end

    if (operator == "=")
      sets.each do |s|
        result = send(formatter_sym, s)
        m.reply "#{s.number}\t\t#{result}"
      end
    elsif (operator == "+")
      results = sets.reduce([]) do |result, s|
        result << send(formatter_sym, s)
      end
      m.reply results.join(', ')
    end
  end

  on :message, /^ping$/ do |m, query|
    unless m.channel?
      m.reply "Pong!"
    end
  end

  on :message, /!help|!pomoc|!setbot/ do |m|
    m.reply "Informacje o setbocie: http://github.com/barnaba/setbot"
  end

  on :message, /^\d+$/ do |m|
    m.reply "Ta opcja nie jest juz wspierana. Informacje o setbocie: http://github.com/barnaba/setbot"
  end
end

bot.start

