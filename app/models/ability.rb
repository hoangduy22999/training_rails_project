# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # alias_action :create, :read, :update, :destroy, to: :crud
    # can :read, :all
    # if user.present?
    #   can :create, UserAnswer, Exam
    #   if !user.admin?
    #     can :crud, User, admin: false
    #     can :crud, Exam, Question
    #   end
    # end
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
      cannot :destroy, User, admin_role: true
    else
      can :read, :all
      can :create, Exam
      can :destroy, Result, user_id: user.id
    end
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
  end
end
