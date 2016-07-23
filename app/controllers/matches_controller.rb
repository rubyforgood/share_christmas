class MatchesController < ApplicationController
  before_action :authorize_by_membership, only: :create

  def create
    match = Match.create(recipient_id: @recipient.id, membership_id: @membership.id)
    redirect_to user_show_path
  end

  private

  def authorize_by_membership
    @recipient = Recipient.find(params[:match][:recipient_id])
    organization_id = @recipient.organization_campaign.organization_id
    @membership = Membership.where(user_id: current_user.id, organization_id: organization_id).first
    if @membership.nil?
      flash[:warning] = 'You must be a member of the organization to donate.'
      redirect_to :root
    end
  end
end
