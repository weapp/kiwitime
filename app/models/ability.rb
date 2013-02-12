class Ability
  include CanCan::Ability

  def initialize(user)

    alias_action :show, :index, :to=> :read

    user ||= User.new # guest user (not logged in)

    if user.new_record?
      # si no estas logueado no tienes permiso para nada
    elsif user.has_role? :admin
      can :manage, :all

    elsif user.has_role? :approved
      can [:read, :update, :destroy], User, id: user.id

      #Product Owners
      owner = Project.with_role(:product_owner, user).map{ |project| project.id }
      can :read, Project, :id => owner
      can [:suggest, :destroy, :read, :accept, :reject], Task, project_id: owner
      can [:manage], Comment, task: {project_id: owner}

      can [:sort], Task, {project_id: owner}

      if user.has_role? :developer or user.has_role? :scrum_master
        can :read, User
        can [:read], Comment
        can [:manage], Comment, user_id: user.id
        can :read, Project
        can [:suggest, :read, :start, :stop, :update], Task
        can [:read], Sprint
      end

      if user.has_role? :scrum_master
        can [:accept, :reject, :sort], Task
        can [:manage], [Sprint, Working]
      end

    elsif false
      can :manage, [Project, Task,  Sitting, Comment, Sprint, Working]
    end
  end

end
