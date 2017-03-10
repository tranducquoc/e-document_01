class GroupMembersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  load_resource :organization
  load_resource :team

  def create
    @group_member = current_user.group_members.build group_member_params
    if @group_member.save
      case params[:group_members][:group_type]
      when "organization"
        member = @organization.members.find_by user_id: current_user.id
      when "team"
        member = @team.members.find_by user_id: current_user.id
      end
      respond_to do |format|
        format.html do
          render partial: "shared/leave",
            locals: {member: member}
        end
      end
    end
  end

  def update

    status = if @group_member.update_attributes group_member_params
      t "team.admin.add"
    else
      t "team.admin.add_fail"
    end
    respond_to do |format|
      format.json do
        render json: {status: status}
      end
    end
  end

  def destroy
    group_type = params[:group_members][:group_type]
    admins = GroupMember.group_admin(GroupMember.group_types[eval ":#{group_type}"],
      (eval "@#{group_type}").id)
    is_admin = (eval "@#{group_type}").has_admin?(current_user).present?
    action = params[:group_members][:action]

    if (admins.length > 1 && action == "leave" && is_admin) || !is_admin
      if @group_member.destroy
        object = eval "@#{params[:group_members][:group_type]}"
        respond_to do |format|
          format.html do
            render partial: "shared/join",
              locals: {object: object}
          end
        end
      end
    else
      status = t "organizations.destroy.can_cannot_leave"
      respond_to do |format|
        format.json do
          render json: {status: status}
        end
      end
    end
  end

  private

  def group_member_params
    params.require(:group_members).permit :group_id, :group_type, :role, :confirm
  end

end
