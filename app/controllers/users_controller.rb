class UsersController < ApplicationController
  before_action :authenticate_user!

  def styleguide
    @user = User.new
  end

  def show
    @memberships = current_user.memberships.includes(
      recipients: {
        organization_campaign: :campaign
      }
    )
    has_matches = @memberships.any? { |membership| membership.recipients.any? }
    @campaign_date = has_matches ? find_campaign_date(@memberships) : Date.today
  end

  private

  # PENDING: A better understanding of what this date represents will help to
  # clean up this controller code
  def find_campaign_date(memberships)
    membership = memberships.detect { |mem| mem.recipients.any? }
    campaign = membership.recipient.organization_campaign.campaign
    @campaign_date = campaign.donation_deadline
  end
end
