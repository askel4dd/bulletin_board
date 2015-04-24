require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  setup do
    @comment = comments(:dimon_comment)
  end
  test "new_comment notification" do
    assert_emails 1 do
      @email = UserMailer.new_comment(@comment).deliver_now
    end
    
    assert_equal "New comment!", @email.subject
    assert_equal [@comment.advert.user.email], @email.to
    assert_equal ["from@example.com"], @email.from
    assert_match /#{@comment.user.login}/, @email.body.encoded
  end
end
