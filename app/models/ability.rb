class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.athlete?
      #User Model
      self_only(:read, User, user)
      self_only(:edit, User, user)
      self_only(:update, User, user)
      cannot [:index], User
      #Club Model
      can :create, Club
      can :read, Club
      user_rights(:edit, Club, user)
      user_rights(:update, Club, user)
      user_rights(:destroy, Club, user)
    else
      can :read, Club
    end
  end

private

  def self_only(action, model, user)
    can action, model do |member|
      member.try(:id) == user.id
    end
  end

  def user_rights(action, model, user)
    can action, model do |member|
      member.try(:user) == user
    end
  end
end
