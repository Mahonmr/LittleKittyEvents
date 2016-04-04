class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.athlete?
      #User Model
      cannot [:index], User
      can [:read, :edit, :update, :destroy], User do |member|
        member.try(:id) == user.id
      end
      #Club Model
      can [:add_club, :create, :read], Club
      can [:edit, :update, :destroy,], Club do |club|
        club.club_users.where(manager_id: user.id).any?
      end
    else
      can :read, Club
    end
  end
end
