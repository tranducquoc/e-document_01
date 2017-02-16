class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    case user.role
    when "admin"
      can :manage, :all
    when "member"
      can :read, :all
      can :create, [Favorite, Document, Comment, Download, Coin, Review]
      can :destroy, [Favorite, Document, Review], user_id: user.id
      can :manage, Relationship
      can :update, [Review, Buycoin], user_id: user.id
    else
      can :read, :all
    end
  end
end
