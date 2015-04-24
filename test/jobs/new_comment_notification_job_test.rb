require 'test_helper'

class NewCommentNotificationJobTest < ActiveJob::TestCase
  setup do
    @comment = comments(:dimon_comment)
  end

  test "number of enqueued jobs matches the given number" do
    assert_enqueued_jobs 1 do
      NewCommentNotificationJob.perform_later(@comment)
    end
  end

  test "job has been enqueued with the given arguments" do
    assert_enqueued_with(job: NewCommentNotificationJob, args: [@comment], queue: 'default') do
      NewCommentNotificationJob.perform_later(@comment)
    end
  end

  test "job has been performed with the given arguments" do
    assert_performed_with(job: NewCommentNotificationJob, args: [@comment], queue: 'default') do
      NewCommentNotificationJob.perform_later(@comment)
    end
  end

  test "job deliver email" do
    assert_difference('ActionMailer::Base.deliveries.size') do
      perform_enqueued_jobs do
        NewCommentNotificationJob.new.perform(@comment)
      end
    end
  end
end
