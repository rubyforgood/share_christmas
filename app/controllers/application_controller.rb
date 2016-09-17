class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :printer_friendly_request?

  protected

  def printer_friendly_request?
    params.fetch(:format, nil) == 'print'
  end

  def load_org_and_authorize
    org_id = params[:organization_id] || params[:id]
    @org = Organization.friendly.find(org_id)
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
