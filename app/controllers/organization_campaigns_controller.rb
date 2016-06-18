class OrganizationCampaignsController < ApplicationController

  def show
    @oc = OrganizationCampaign.find(params[:id])
    @recipients = @oc.recipients
  end

end
