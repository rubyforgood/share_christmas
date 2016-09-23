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

  private

  def store_campaign
    @organization_campaign = OrganizationCampaign.find(params[:id])
    session[:organization_name] = @organization_campaign.organization_name
    session[:campaign_name] = @organization_campaign.campaign_name
    session[:campaign_logo_url] = @organization_campaign.campaign_logo.url
  end
end
