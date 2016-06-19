class UsersController < ApplicationController
  before_action :authenticate_user!

  def styleguide
    @user = User.new
  end

  def show
    @memberships = current_user.memberships
    if @memberships && @memberships.first.matches
      @campaign_date = @memberships.first.matches.first.recipient.organization_campaign.campaign.donation_deadline
    else
      @campaign_date = Date.today
    end
  end
end
