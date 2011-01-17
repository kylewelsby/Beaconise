require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "password_reset_instructions" do
    @expected.subject = 'Notifier#password_reset_instructions'
    @expected.body    = read_fixture('password_reset_instructions')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifier.create_password_reset_instructions(@expected.date).encoded
  end

  test "welcome" do
    @expected.subject = 'Notifier#welcome'
    @expected.body    = read_fixture('welcome')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifier.create_welcome(@expected.date).encoded
  end

end
