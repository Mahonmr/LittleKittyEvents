class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    elsif user.athlete?
      can :read, User
      can :update, User do |edit_user|
        edit_user.try(:id) == user.id
      end
      can :edit, User do |edit_user|
        edit_user.try(:id) == user.id
      end
    else
      can :read, :all
    end
  end
end
