class Orgadmin::OrganizationCampaignsController < Orgadmin::ApplicationController
  def create
    # Create a linkage between org and campaign.  If the linkage already
    # exists, ignore it.  Otherwise send an email to the Volunteer Center

    org_campaign = OrganizationCampaign.find_or_create_by(organization_campaign_params) do |oc|
      # TODO: this is called if created.  Send email
    end
    redirect_to orgadmin_root_path
  end

  private

  def store_campaign
    @organization_campaign = OrganizationCampaign.find(params[:id])
    session[:organization_name] = @organization_campaign.organization_name
    session[:campaign_name] = @organization_campaign.campaign_name
    session[:campaign_logo_url] = @organization_campaign.campaign_logo.url
  end

  def organization_campaign_params
    params.require(:organization_campaign).permit(:organization_id, :campaign_id)
  end
end
