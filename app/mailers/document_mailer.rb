class DocumentMailer < ApplicationMailer
  def upload_document document, user
    @user = user
    @document = document
    mail to: user.email, subject: t("upload_document")
  end
end
