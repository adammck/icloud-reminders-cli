#!/usr/bin/env ruby
# vim: et ts=2 sw=2

class TestApp < MiniTest::Unit::TestCase
  def setup
    $driver = MiniTest::Mock.new
  end

  def stubbed_app_class
    Class.new(ICloud::Reminders::App) do
      no_tasks do
        def make_driver
          $driver
        end
      end
    end
  end

  def run_app(*argv)
    capture_io do
      stubbed_app_class.start(argv)
    end
  end

  def test_usage
    out, err = run_app
    assert_match %r{^Tasks:}, out
  end

  def test_no_reminders
    $driver.expect(:incomplete_reminders, [])
    out, err = run_app("list")
    assert_equal ["No reminders."], out.split("\n")
    assert_empty err
  end

  def test_list_incomplete_reminders
    $driver.expect(:incomplete_reminders, [
      mock(:title => "Alpha"),
      mock(:title => "Beta")
    ])

    out, err = run_app("list")
    assert_equal ["01. Alpha", "02. Beta"], out.split("\n")
    assert_empty err
  end

  def test_new_reminder
    $driver.expect(:add_reminder, nil, ["Test Reminder"])
    out, err = run_app("new", "Test Reminder")

    assert_empty err
    assert_equal ["Added."], out.split("\n")
    $driver.verify
  end
end
