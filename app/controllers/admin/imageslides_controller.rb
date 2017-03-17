class Admin::ImageslidesController < ApplicationController
  layout "admin"
  before_action :authenticate_user!, :verify_admin
  load_and_authorize_resource

  def index
    @imageslide = Imageslide.new
  end

  # def new
  #   @imageslide = Imageslide.new
  # end

  def create
    @imageslide = Imageslide.new imageslide_params
    if @imageslide.save
      flash[:success] = t ".create_success"
      redirect_to admin_imageslides_url
    else
      render :new
    end
  end

  def update
    if @imageslide.enable?
      @imageslide.update_attributes status: :disable
      flash[:success] = t ".disable_success"
    else
      @imageslide.update_attributes status: :enable
      flash[:success] = t ".enable_success"
    end
    redirect_to admin_imageslides_url
  end

  private
  def imageslide_params
    params.require(:imageslide).permit :image, :status
  end
end
