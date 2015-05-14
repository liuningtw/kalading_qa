class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # 总裁
    if user.manager?
      can :read, :all
      can [:read_init, :read_direct_answer, :read_race, :read_fallback,
           :read_answered, :read_adopted, :read_useless], Question
    end

    # 客服主管
    if user.dispatcher_manager?
      can [:read_init, :check], Question
      can :read_direct_answer, Question
      can :read_race, Question
      can :read_fallback, Question
      can :read_answered, Question
      can :read_adopted, Question
      can :read_useless, Question
    end

    # 客服
    if user.dispatcher?
      can :direct_answer, Question
      can :fallback_answer, Question
    end

  end
end
