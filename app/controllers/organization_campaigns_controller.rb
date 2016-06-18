class OrganizationCampaignsController < ApplicationController

  def show
    @organization_campaign = OrganizationCampaign.find(params[:id])
    @recipients = @organization_campaign.recipients
    @donors = @organization_campaign.organization.memberships
  end

end
