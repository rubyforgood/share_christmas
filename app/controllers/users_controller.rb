class UsersController < ApplicationController
  before_action :authenticate_user!

  def styleguide
    @user = User.new
  end

  def show
    @memberships = current_user.memberships
    has_matches = @memberships.any? && @memberships.first.matches.any?
    if has_matches
      membership = @memberships.first
      match = membership.matches.first
      campaign = match.recipient.organization_campaign.campaign
      @campaign_date = campaign.donation_deadline
    else
      @campaign_date = Date.today
    end
  end
end
