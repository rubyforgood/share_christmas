class RecipientsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_oc_and_authorize
  layout 'org_admin'

  def index
    @recipients = Recipient.includes(:matches).where(
        organization_campaign: @organization_campaign
    )

    if params[:matched] == 'true'
      @recipients = @recipients.where.not(matches: {recipient_id: nil})
    elsif params[:matched] == 'false'
      @recipients = @recipients.where(matches: {recipient_id: nil})
    end
  end

  private

  def load_oc_and_authorize
    @organization_campaign = OrganizationCampaign.find(params[:organization_campaign])
    authorize! :admin, @organization_campaign.organization
  end
end
