class DownloadsController < ApplicationController
  before_action :authenticate_user!

  def create
    file_id = params[:download][:document_id]
    @document = Document.find_by id: file_id
    file_name = @document.attachment.file.filename
    @download = @document.downloads.build
    @download.user = current_user
    send_file Rails.root.join("public", "uploads", "document", "attachment",
      file_id, file_name)
    current_user.update_attributes point: current_user.point - Settings.coin_down
    @user = @document.user
    @user.update_attributes point: @user.point + Settings.coin_up
    @download.save!
  end
end
