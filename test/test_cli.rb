#!/usr/bin/env ruby
# vim: et ts=2 sw=2

class TestCli < MiniTest::Unit::TestCase
  def setup
    @driver = MiniTest::Mock.new
  end

  def cli(command_line="")
    ICloudRemindersCli.new(*command_line.split).tap do |cli|
      cli.instance_variable_set(:@driver, @driver)
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
    @driver.expect(:reminders, [])

    out, err = capture_io do
      cli("-l").run
    end

    assert_equal "", err
    assert_equal ["No reminders."], out.split("\n")
  end

  def test_list_reminders
    @driver.expect(:reminders, [
      mock(title: "Alpha"),
      mock(title: "Beta")
    ])

    out, err = capture_io do
      cli("-l").run
    end

    assert_equal "", err
    assert_equal ["01. Alpha", "02. Beta"], out.split("\n")
  end

  def test_new_reminder
    @driver.expect(:add_reminder, nil, ["Test Reminder"])

    out, err = capture_io do
      cli("-n Test Reminder").run
    end

    assert_equal "", err
    assert_equal ["Added."], out.split("\n")
    @driver.verify
  end
end
