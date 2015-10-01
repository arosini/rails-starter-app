# Defines abilties/authorization for different roles.
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
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    user ||= User.new # guest user (not logged in) if user not defined

    # Guest abilties
    if user.guest?
      can :index, HomeController

    # Admin abilities
    elsif user.admin?
      can :manage, :all # Can do anything!
      # ...except this (view the landing page).
      cannot :index, HomeController

    # User abilities
    elsif user.user?
      user_id = user.id
      # Can read any other User (not Admins)
      can :read, User, roles: { name: 'User' }
      can :index, User

      # Can check if their current password was entered correctly
      can :check_password_match, User, id: user_id

      # Can edit/delete themselves
      can [:edit, :update, :delete, :destroy], User, id: user_id
    end
  end
end
