module Orgadmin
  class OrganizationCampaignsController < Orgadmin::ApplicationController
    def create
      # Create a linkage between org and campaign.  If the linkage already
      # exists, ignore it.  Otherwise send an email to the Volunteer Center

      OrganizationCampaign.find_or_create_by(organization_campaign_params) do |oc|
        # TODO: this is called if created.  Send email
      end
      redirect_to orgadmin_root_path
    end

    private

    def organization_campaign_params
      params.require(:organization_campaign).permit(:organization_id, :campaign_id)
    end
  end
end
