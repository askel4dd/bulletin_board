class NewCommentNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(comment)
    @comment = comment
    UserMailer.new_comment(@comment).deliver_later
  end
end
