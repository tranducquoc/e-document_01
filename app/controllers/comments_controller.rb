class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    @document = Document.find_by id: params[:document_id]
    @comment = @document.comments.new comment_params
    @comment.user = current_user
    if @comment.save!
      respond_to do |format|
        format.html{redirect_to @document}
        format.js
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit :content
  end
end
