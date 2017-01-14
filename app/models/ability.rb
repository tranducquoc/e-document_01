class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    case user.role
    when "admin"
      can :manage, :all
    when "member"
      can :read, :all
      can :create, [Favorite, Document, Comment]
      can :destroy, [Favorite, Document], user_id: user.id
    else
      can :read, :all
    end
  end
end
