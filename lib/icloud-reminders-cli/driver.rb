#!/usr/bin/env ruby
# vim: et ts=2 sw=2

require "icloud"

module ICloud
  module Reminders
    class Driver
      def initialize(username, password)
        @session ||= ICloud::Session.new(username, password)
      end

      def list_reminders
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