class Orgadmin::CampaignsController < Orgadmin::ApplicationController
  def switch_current_campaign
    session[:current_campaign] = params[:organization_campaign][:campaign_id]
    redirect_to orgadmin_root_path
  end
end
