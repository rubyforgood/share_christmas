class OrganizationCampaignsController < ApplicationController
  before_action :store_campaign
  before_action :authenticate_user!

  def show
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
