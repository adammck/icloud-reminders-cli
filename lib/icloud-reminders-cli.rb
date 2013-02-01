#!/usr/bin/env ruby
# vim: et ts=2 sw=2

require "icloud"
require "trollop"

class ICloudRemindersCli
  def initialize
    @options = nil
  end

  def parse(argv=[])
    self.tap do
      @options = Trollop::options(argv) do
        opt :list, "Show existing reminders"
      end
    end
  end

  def usage
    "Usage: icloud-reminders-cli [options]"
  end

  def run
    if @options[:list]
      reminders.tap do |r|
        if r.any?
          r.each_with_index do |reminder, i|
            puts(sprintf("%02d. %s", (i+1), reminder.title))
          end
        else
          puts("No reminders.")
        end
      end
    else
      $stderr.puts(usage)
    end
  end

  def reminders
    session.reminders#.reject(&:completed_date)
  end

  private

  def session
    @session ||= ICloud::Session.new(apple_id, password)
  end

  def apple_id
    ENV["APPLE_ID"] or raise "Apple ID not set"
  end

  def password
    ENV["APPLE_PW"] or raise "Password not set"
  end
end
