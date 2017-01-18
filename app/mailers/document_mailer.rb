class DocumentMailer < ApplicationMailer
  def upload_document document, user
    @document = document
    @user = user
    mail to: user.email, subject: t("upload_document")
  end
end
