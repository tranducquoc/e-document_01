class FavoritesController < ApplicationController
  before_action :verify_user

  def create
    @document = Document.find_by id: params[:document_id]
    @favorite = @document.favorites.build
    @favorite.user = current_user
    if @favorite.save!
      respond_to do |format|
        format.html{redirect_to @document}
        format.js
      end
    end
  end

  def destroy
    @favorite = Favorite.find_by id: params[:id]
    @document = @favorite.document
    @favorite.destroy
    respond_to do |format|
      format.html{redirect_to @document}
      format.js
    end
  end
end
