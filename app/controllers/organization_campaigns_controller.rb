class OrganizationCampaignsController < ApplicationController
  before_action :authenticate_user!

  def show
    store_campaign
    @recipients = @organization_campaign.recipients
    @donors = @organization_campaign.organization.memberships
    @match = Match.new
  end

  def create
    # Create a linkage between org and campaign.  If the linkage already 
    # exists, ignore it.  Otherwise send an email to the Volunteer Center

    OrganizationCampaign.find_or_create_by(organization_campaign_params) do |oc|
      # TODO: this is called if created.  Send email
    end 
    redirect_to controller: :organizations, action: :show, 
      id: params[:organization_campaign][:organization_id]
  end

  private

  def store_campaign
    @organization_campaign = OrganizationCampaign.find(params[:id])
    session[:organization_name] = @organization_campaign.organization_name
    session[:campaign_name] = @organization_campaign.campaign_name
    session[:campaign_logo_url] = @organization_campaign.campaign_logo.url
  end

  def organization_campaign_params
    params.require(:organization_campaign).permit(:organization_id,:campaign_id)
  end

end
