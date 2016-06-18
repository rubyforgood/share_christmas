class UsersController < ApplicationController
  def edit
    @user = User.new
  end

  def update
    redirect_to :signup
  end
end
