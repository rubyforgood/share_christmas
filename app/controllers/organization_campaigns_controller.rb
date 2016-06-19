class OrganizationCampaignsController < ApplicationController
  before_action :authenticate_user!
  def show
    @organization_campaign = OrganizationCampaign.find(params[:id])
    @recipients = @organization_campaign.recipients
    @donors = @organization_campaign.organization.memberships
    @match = Match.new
  end

end
