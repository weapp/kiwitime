class Ability
  include CanCan::Ability

  def initialize(user)

    alias_action :show, :index, :to=> :read

    user ||= User.new # guest user (not logged in)




    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :approved

      owner = Project.with_role(:product_owner, user).map{ |project| project.id }
      can :read, Project, :id => owner
      can [:suggest, :destroy, :sort, :read, :accept, :reject], Task, :project_id => owner

    elsif !user.new_record?
      #can :index, Project
    elsif false
      can :manage, User, :id => user.id
      can :read, :all
      can :manage, [Project, Task,  Sitting, Comment, Sprint, Working]
    else
      #can :manage, :all
    end
  end

end
