class Orgadmin::AppealsController < Orgadmin::ApplicationController
  def new
    org_campaign = OrganizationCampaign.find(params[:organization_campaign])
    @campaign = org_campaign.campaign
    @memberships = org_campaign.organization.memberships_with_email
    url = organization_campaign_url(org_campaign)
    @appeal = Appeal.new(
      organization_campaign_id: org_campaign.id,
      content: "
        <p>Please use this URL to sign up for the campaign</p>
        <p>#{view_context.link_to url}</p>
        <p>Thanks!</p>
      ",
      subject: @campaign.name
    )
  end

  def create
    appeal = Appeal.new(params[:appeal])
    appeal.send(current_user)
    redirect_to orgadmin_root_path
  end
end
