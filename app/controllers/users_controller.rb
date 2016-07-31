class UsersController < ApplicationController
  before_action :authenticate_user!

  def styleguide
    @user = User.new
  end

  def show
    @memberships = current_user.memberships
    has_matches = @memberships.any? && @memberships.first.matches.any?
    @campaign_date = has_matches ? find_campaign_date(@memberships) : Date.today
  end

  private

  def find_campaign_date(memberships)
    membership = memberships.first
    match = membership.matches.first
    campaign = match.recipient.organization_campaign.campaign
    @campaign_date = campaign.donation_deadline
  end
end
