#!/usr/bin/env ruby
# vim: et ts=2 sw=2

require "trollop"

module ICloud
  module Reminders
    class Cli
      def initialize(*argv)
        @options = Trollop::options(argv) do
          opt :list, "Show existing reminders"
          opt :new, "Create a reminder", :type => :strings
        end
      end

      def usage
        "Usage: icloud-reminders-cli [options]"
      end

      def error(str)
        $stderr.puts(str)
      end

      def run
        if @options[:list]
          driver.reminders.tap do |r|
            if r.any?
              r.each_with_index do |reminder, i|
                puts(sprintf("%02d. %s", (i+1), reminder.title))
              end
            else
              puts("No reminders.")
            end
          end

        elsif @options[:new]
          driver.add_reminder(@options[:new].join(" "))
          puts("Added.")

        else
          error(usage)
        end
      end

      private

      def driver
        @driver ||= Driver.new(apple_id, password)
      end

      def apple_id
        ENV["APPLE_ID"] or raise "Apple ID not set"
      end

      def password
        ENV["APPLE_PW"] or raise "Password not set"
      end
    end
  end
end
