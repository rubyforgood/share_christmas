class MatchesController < ApplicationController
  def create
    # TODO: implement this
    flash[:error] = 'unable to match you with this recipient.'
    redirect_to user_show_path
  end
end
