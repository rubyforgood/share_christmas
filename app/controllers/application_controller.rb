class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :printer_friendly_request?

  def authenticate_active_admin_user!
    authenticate_user!
    unless current_user.roles.include? :volunteer_center_admin
      flash[:alert] = 'You are not authorized to access this resource!'
      redirect_to root_path
    end
  end

  protected

  def printer_friendly_request?
    params.fetch(:format, nil) == 'print'
  end
end
