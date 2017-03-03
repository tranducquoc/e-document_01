class Api::ImageslidesController < ApplicationController
  def index
    @imageslides = params[:image_name].present? ? Imageslide.search(
      params[:image_name]) : Imageslide.all
    respond_to do |format|
      format.html do
        render partial: "admin/imageslides/imageslides",
        locals: {imageslides: @imageslides}
      end
    end
  end
end
