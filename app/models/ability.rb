class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, VolunteerCenter, 
      :id => VolunteerCenter.with_role(:admin, user).pluck(:id)
    can :manage, Organization, 
      :id => Organization.with_role(:admin, user).pluck(:id)

  end
end
