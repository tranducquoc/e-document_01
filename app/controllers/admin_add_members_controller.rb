class AdminAddMembersController < ApplicationController
  before_action :authenticate_user!
  load_resource :organization
  load_resource :team
  load_resource :group_member

  def create
    if @organization.is_admin?(current_user) || @team.has_admin?(current_user)
      @group_member = GroupMember.new add_member_params
      if @group_member.save
        status = t "organizations.show.added_member"
        respond_to do |format|
          format.json do
            render json: {status: status}
          end
        end
      end
    end
  end

  def destroy
    if @group_member.organization?
      @group_members = GroupMember.member_team_organization(
        @group_member.user_id, @group_member.group_id).destroy_all
    end
    if (@organization.is_admin?(current_user) || @team.has_admin?(current_user)) &&
      @group_member.destroy
      respond_to do |format|
        format.json do
          render json: {status: status}
        end
      end
    end
  end

  private

  def add_member_params
    params.require(:group_members).permit :user_id,
      :group_id, :group_type, :confirm
  end

end
