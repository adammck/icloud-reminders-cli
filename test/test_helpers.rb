#!/usr/bin/env ruby
# vim: et ts=2 sw=2

require "minitest/mock"

# Ensure that we don't accidentally do any HTTP requests while testing. The
# relevant bits should be stubbed out anyway, but this will raise rather than
# failing. We don't use FakeWeb otherwise.
require "fakeweb"
FakeWeb.allow_net_connect = false

class Object
  def mock(methods)
    Object.new.tap do |obj|
      methods.each do |key, val|

        # Ruby 1.8.7 doesn't have define_singleton_method :(
        (class << obj; self; end).send(:define_method, key, lambda { val })
      end
    end
  end
end
