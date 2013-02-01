#!/usr/bin/env ruby
# vim: et ts=2 sw=2

class TestCli < MiniTest::Unit::TestCase
  def setup
    @cli = ICloudRemindersCli.new
    @session = MiniTest::Mock.new
    @cli.instance_variable_set(:@session, @session)
  end

  def test_usage
    out, err = capture_io do
      @cli.parse([]).run
    end

    assert_equal "", out
    assert_match %r{^Usage:}, err
  end

  def test_no_reminders
    @session.expect(:reminders, [])

    out, err = capture_io do
      @cli.parse(["-l"]).run
    end

    assert_equal "", err
    assert_equal "No reminders.\n", out
  end
end
