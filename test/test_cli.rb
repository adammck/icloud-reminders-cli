#!/usr/bin/env ruby
# vim: et ts=2 sw=2

class TestCli < MiniTest::Unit::TestCase
  def setup
    @session = MiniTest::Mock.new
  end

  def cli(*argv)
    ICloudRemindersCli.new(*argv).tap do |cli|
      cli.instance_variable_set(:@session, @session)
    end
  end

  def test_usage
    out, err = capture_io do
      cli.run
    end

    assert_match %r{^Usage:}, err
    assert_equal "", out
  end

  def test_no_reminders
    @session.expect(:reminders, [])

    out, err = capture_io do
      cli("-l").run
    end

    assert_equal "", err
    assert_equal "No reminders.\n", out
  end

  def test_list_reminders
    @session.expect(:reminders, [
      mock(title: "Alpha"),
      mock(title: "Beta")
    ])

    out, err = capture_io do
      cli("-l").run
    end

    assert_equal "", err
    assert_equal ["01. Alpha", "02. Beta"], out.split("\n")
  end
end
