class UsersController < ApplicationController
  before_action :authenticate_user!

  def styleguide
    @user = User.new
  end

  def show
    @memberships = current_user.memberships
  end
end
