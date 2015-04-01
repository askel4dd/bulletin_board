class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role? :admin
      can :manage, :all
    elsif user.role? :moderator
      can :manage, Advert
    elsif user.role? :generic
      can :read, [User, Advert]
      can :manage, Advert do |advert|
        advert.try(:user) == user
      end
    elsif user
      can :create, User
      can :read, [User, Advert]
    end
    # here are :read, :create, :update and :destroy.
  end
end
