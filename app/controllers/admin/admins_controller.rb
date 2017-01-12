class Admin::AdminsController < ApplicationController
  load_and_authorize_resource
  layout "admin"

  def index
  end
end
