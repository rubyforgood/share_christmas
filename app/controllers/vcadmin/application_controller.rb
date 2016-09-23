class Vcadmin::ApplicationController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize
  layout 'org_admin'

  def authorize
    
  end
end