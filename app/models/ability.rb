class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    case user.role
    when "admin"
      can :manage, :all
    when "member"
      can :read, :all
      can :create, [Favorite, Document, Comment, Download, Coin, Review, Organization, GroupMember]
      can :destroy, [Favorite, Document, Review, Organization, GroupMember], user_id: user.id
      can :manage, Relationship
      can :update, [Review, Buycoin, Organization, GroupMember], user_id: user.id
    else
      can :read, :all
    end
  end
end
