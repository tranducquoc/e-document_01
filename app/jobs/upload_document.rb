class UploadDocument < Struct.new(:document, :user)
  def perform
    DocumentMailer.upload_document(document, user).deliver
  end
end
