class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  layout 'org_admin'

  def show
    @org = Organization.friendly.find(params[:id])
    @organization_campaign = find_organization_campaign
    @joined_campaigns = @org.campaigns
    @joinable_campaigns = @org.joinable_campaigns
    @organization_campaign_new = OrganizationCampaign.new(organization_id: @org.id)
  end

  def switch_current_campaign
    session[:current_campaign] = params[:organization_campaign][:campaign_id]
    redirect_to organization_path(params[:id])
  end

end
