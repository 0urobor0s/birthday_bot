require "./birthdays"
require "yaml"
require "slack"
require "schedule"
require "kemal"

# TODO: Write documentation for `BirthdayBot`
module BirthdayBot  
  def self.main
    bds = Birthdays.new
    schedule = Schedule::Runner.new

    Schedule.exception_handler do |ex|
      puts "Exception recued! #{ex.message}"
    end

    schedule.every(:day, "10:00:00") do
      bds.today.each do |b|
        msg = "Happy birthday <@#{b[1]}> ::birthday:"
        puts "Sending: #{msg}"
        message = Slack::Message.new(msg, channel: "birthdays")
        message.send_to_hook ENV["WEBHOOK_URL"]
      end
    end
  end
end

BirthdayBot.main

get "/" do
  "The answer is 42."
end

Kemal.run
