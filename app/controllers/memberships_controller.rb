class MembershipsController < ApplicationController
  before_action :authenticate_user!
  layout 'org_admin'

  def index
    # TODO: Make sure user has org admin role for this org
    @memberships = Membership.where(search_membership_params)
  end

private

  def search_membership_params
    params.permit(:organization_id, :org_admin)
  end


end