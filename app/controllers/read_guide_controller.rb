class ReadGuideController < ApplicationController
  load_resource :organization
  load_resource :read_guide

  def create
    ReadGuide.create!(Organization_id: @organization.id, User_id: params[:user_id])
  end

  def update
    @read_guide.update_attributes read: ReadGuide.reads[:done]
  end

  def destroy
    @read_guide.destroy
  end

end
