class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role? :admin
      can :manage, :all
    elsif user.role? :moderator
      can :manage, [Advert, Comment, user]
    elsif user.role? :generic
      can :manage, user
      can :manage, Advert, user_id: user.id
      can :manage, Comment, user_id: user.id
      can :read, [User, Advert, Comment]
      can :create, [Advert, Comment]
    elsif user
      can :create, User
      can :read, [User, Advert, Comment]
    end
    # here are :read, :create, :update and :destroy.
  end
end
