class Ability
  include CanCan::Ability

  def initialize user, controller_namespace
    case controller_namespace
    when "Admin"
      can :manage, :all if user.admin?
    else
      can :read, :all
      can :manage, User
      can [:create], Document
    end
  end
end
