module Vcadmin
  class ApplicationController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize
    layout 'org_admin'

    def authorize
      raise CanCan::AccessDenied unless current_user.has_role? :admin
    end
  end
end
