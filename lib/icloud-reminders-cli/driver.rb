#!/usr/bin/env ruby
# vim: et ts=2 sw=2

require "icloud"

module ICloud
  module Reminders

    #
    # This class is a thin wrapper around ruby-icloud, to be called by the CLI.
    # It mostly exists just to be stubbed out.
    #
    class Driver
      def initialize(username, password)
        @session ||= ICloud::Session.new(username, password)
      end

      def incomplete_reminders
        @session.reminders.reject(&:completed_date)
      end

      def all_reminders
        @session.reminders
      end

      def add_reminder(title)
        @session.post_reminder(ICloud::Records::Reminder.new.tap do |r|
          r.title = title
        end)
      end
    end
  end
end
