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
        obj.define_singleton_method(key) do
          val
        end
      end
    end
  end
end
