class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
    #
    # Roles for user are: :participant, :moderator, :admin

    user ||= User.new(roles: :public, name: "Senior Guest") # handle guest user, who is just a participant
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :moderator
      can :read, :all
      can :update, :all do 
        |clazz|
          clazz.managed_by? user
      end
    elsif user.has_role? :participant
      can :update, :all do
        |clazz|
          clazz.owned_by? user
      end
      can :read, :all do
        |clazz|
          clazz.visible_to? user
      end
    end
  end
end

