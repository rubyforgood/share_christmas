class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, :all if user.has_role? :admin

    can :manage, Organization,
        id: Organization.with_role(:admin, user).pluck(:id)
  end
end
