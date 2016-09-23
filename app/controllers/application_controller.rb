class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :printer_friendly_request?

  protected

  def printer_friendly_request?
    params.fetch(:format, nil) == 'print'
  end

end
