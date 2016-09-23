class Orgadmin::ApplicationController < ApplicationController
  before_action :authenticate_user!
  before_action :load_org_and_authorize
  layout 'org_admin'

  def load_org_and_authorize
    # TODO: If the user is member of more than one org, give them a choice
    orgs_user_is_admin_of = Organization.with_role(:admin, current_user)
    @org = orgs_user_is_admin_of.first
    authorize! :admin, @org
  end

  def find_organization_campaign
    session[:current_campaign] ||= @org.current_campaign.nil? ? nil : @org.current_campaign.id
    return nil if session[:current_campaign].nil?
    OrganizationCampaign.find_by_organization_id_and_campaign_id(
      @org.id,
      session[:current_campaign]
    )
  end
end