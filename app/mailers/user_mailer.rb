class UserMailer < ApplicationMailer
  def send_email
    @users = User.send_mail_if_not_login
    @users.each do |user|
      mail to: user.email, subject: t(".send_mail_not_login")
    end
  end
end
