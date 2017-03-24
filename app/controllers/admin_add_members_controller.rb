class AdminAddMembersController < ApplicationController
  before_action :authenticate_user!
  load_resource :organization
  load_resource :team
  load_resource :group_member

  def create
    if @organization.has_admin?(current_user) || @team.has_admin?(current_user)
      params[:group_members][:user_id].each do |user_id|
        @group_member = GroupMember.new user_id: user_id,
          group_id: params[:group_members][:group_id],
          group_type: params[:group_members][:group_type],
          confirm: params[:group_members][:confirm]
        if @group_member.save
          status = t "organizations.show.added_member"
        else
          status = t "organizations.show.cannot_add"
          break
        end
      end
      respond_to do |format|
        format.json do
          render json: {status: status}
        end
      end
    end
  end

  def destroy
    if @group_member.organization?
      @group_members = GroupMember.member_team_organization(
        @group_member.user_id, @group_member.group_id).destroy_all
    end
    if (@organization.has_admin?(current_user) || @team.has_admin?(current_user)) &&
      if @group_member.destroy
        read_guide = ReadGuide.find_by Organization_id: @group_member.group_id,
          User_id: @group_member.user_id
        read_guide.destroy if read_guide
        respond_to do |format|
          format.json do
            render json: {status: status}
          end
        end
      end
    end
  end

end
