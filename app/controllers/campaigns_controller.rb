class CampaignsController < ApplicationController
  def show
    @organization_campaign = OrganizationCampaign.find(params[:id])
  end
end
