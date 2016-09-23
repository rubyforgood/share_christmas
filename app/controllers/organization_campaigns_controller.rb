class OrganizationCampaignsController < ApplicationController
  before_action :authenticate_user!

  def show
    store_campaign

    @membership = Membership.find_by_organization_id_and_user_id(
      @organization_campaign.id,
      current_user.id
    )

    @recipients = @organization_campaign.recipients
    @donors = @organization_campaign.organization.memberships
  end

end