class Admin::AdminsController < ApplicationController
  before_action :authenticate_user!, :verify_admin
  layout "admin"

  def index
  end
end
