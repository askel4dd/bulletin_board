class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_comment.subject
  #
  def new_comment(comment)
    @comment = comment
    @greeting = "Hi"

    mail to: @comment.advert.user.email, subject: "New comment!"
  end
end
