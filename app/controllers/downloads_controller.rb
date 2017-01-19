class DownloadsController < ApplicationController
  before_action :authenticate_user!

  def create
    file_id = params[:download][:document_id]
    count_download = params[:download][:count_download]
    @document = Document.find_by id: file_id
    unless @document
      flash.now[:warning] = t "document.not_found"
      render_404
    end
    file_name = @document.attachment.file.filename
    @download = @document.downloads.build
    @download.user = current_user
    send_file Rails.root.join("public", "uploads", "document", "attachment",
      file_id, file_name)
    @user = @document.user
    unless current_user == @user
      if count_download.to_i >= Settings.count_free_download.to_i
        current_user.update_attributes point: current_user.point - Settings.coin_down
        @user.update_attributes point: @user.point + Settings.coin_up
      else
        current_user.update_attributes point: current_user.point - Settings.coin_free
        @user.update_attributes point: @user.point + Settings.coin_up
      end
      @download.save!
    end
  end
end
