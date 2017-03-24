class DownloadsController < ApplicationController
  before_action :authenticate_user!

  def create
    @document = Document.find_by id: params[:download][:document_id]

    file_name = @document.attachment.file.filename
    @download = @document.downloads.build user_id: current_user.id

    send_file Rails.root.join("public", "uploads", "document", "attachment",
      params[:download][:document_id], file_name)
  end
end
