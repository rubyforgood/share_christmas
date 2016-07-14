class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_org_and_authorize
  layout 'org_admin'

  def index
    @memberships = @org.memberships.includes(:user).order("users.last_name, users.first_name")
  end    

private
  def load_org_and_authorize 
    @org = Organization.friendly.find(params[:organization_id])
    authorize! :admin, @org
  end 

end