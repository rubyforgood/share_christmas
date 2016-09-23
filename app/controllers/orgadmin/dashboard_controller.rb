class Orgadmin::DashboardController < Orgadmin::ApplicationController
  def index
    @organization_campaign = find_organization_campaign
    @joined_campaigns = @org.campaigns
    @joinable_campaigns = @org.joinable_campaigns
    @organization_campaign_new = OrganizationCampaign.new(organization_id: @org.id)
  end
end
