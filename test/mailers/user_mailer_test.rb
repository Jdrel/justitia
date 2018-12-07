require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "new_consultation" do
    mail = UserMailer.new_consultation
    assert_equal "New consultation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
