class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.roles.include? :volunteer_center_admin
      can :manage, :all
    elsif user.roles.include? :org_admin
      can :manage, Organization do |org|
        org.memberships.include? user
      end
    else
      can :read, :all
    end
  end
end
