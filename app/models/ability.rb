class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role? :admin
      can :manage, :all
    elsif user.role? :moderator
      can :manage, [Advert, Comment]
      can :manage, user
    elsif user.role? :generic
      can :manage, user
      can :read, [User, Advert, Comment]
      can :create, [Advert, Comment]
      can :manage, Advert do |advert|
        advert.try(:user) == user
      end
      can :manage, Comment do |comment|
        comment.try(:user) == user
      end
    elsif user
      can :create, User
      can :read, [User, Advert, Comment]
    end
    # here are :read, :create, :update and :destroy.
  end
end
