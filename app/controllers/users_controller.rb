class UsersController < ApplicationController
  before_action :authenticate_user!

  def styleguide
    @user = User.new
  end

  def show
    @memberships = current_user.memberships
    @campaign_date = if @memberships && @memberships.first.matches
                       @memberships.first.matches.first.recipient.organization_campaign.campaign.donation_deadline
                     else
                       Date.today
                     end
  end
end
