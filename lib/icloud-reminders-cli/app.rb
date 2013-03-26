#!/usr/bin/env ruby
# vim: et ts=2 sw=2

require "thor"

module ICloud
  module Reminders
    class App < Thor

      desc "list", "List reminders"
      method_option :all, :type => :boolean, :aliases => "-a"
      def list
        reminders = if options[:all]
          driver.all_reminders
        else
          driver.incomplete_reminders
        end

        if reminders.any?
          reminders.each_with_index do |reminder, i|
            puts reminder.title

            reminder.alarms.each do |alarm|
              puts("Date: " + alarm.on_date.strftime("%d/%m/%Y %H:%M")) if alarm.on_date
            end

            puts
          end
        else
          puts("No reminders.")
        end
      end

      desc "new TITLE", "Add a reminder"
      def new(title)
        driver.add_reminder(title)
        puts "Added."
      end

      private

      def driver
        @driver ||= make_driver
      end

      # Stub me!
      def make_driver
        Driver.new(apple_id, password)
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
