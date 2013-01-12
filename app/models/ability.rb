class Ability
  include CanCan::Ability

  def initialize(user)

    alias_action  :report, :show, :index, :to=> :read

    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif !user.new_record?
      can :read, :all
      can :manage, User, :id => user.id
      can :manage, [Project, Task, Sitting]
    else
      #can :manage, :all
    end
  end
end
