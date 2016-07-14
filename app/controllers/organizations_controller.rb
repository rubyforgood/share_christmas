class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  layout 'org_admin'

  def show
    @org = Organization.friendly.find(params[:id])
    session[:current_campaign] ||= @org.current_campaign.nil? ? nil : @org.current_campaign.id
    if session[:current_campaign].nil?
      @organization_campaign = nil
    else
      @organization_campaign = OrganizationCampaign.where(
        organization_id: @org.id,
        campaign_id: session[:current_campaign]
      ).first
    end
    @joined_campaigns =  @org.campaigns
    @joinable_campaigns = @org.joinable_campaigns
    @organization_campaign_new = OrganizationCampaign.new(organization_id: @org.id)
  end

  def switch_current_campaign
    session[:current_campaign] = params[:organization_campaign][:campaign_id]
    redirect_to organization_path(params[:id])
  end
end
