class RecipientsController < ApplicationController
  def index
    load_org_and_authorize
    @oc = find_organization_campaign
    @recipients = @oc.recipients
  end

  def edit
    load_org_and_authorize
    @user = User.new
    @membership = Membership.new
    @recipient = Recipient.find(params[:id])
    @memberships = @org.memberships_sorted_by_name
  end

  def update
    recipient = Recipient.find(params[:id])
    recipient.update(membership_id: params[:recipient][:membership_id])
    # Destination depends on where match came from: org admin, or user
    if params[:organization_id]
      @org = Organization.friendly.find(params[:organization_id])
      redirect_to organization_recipients_path(@org)
    else
      flash[:message] = "Thank you for helping #{recipient.first_name}!"
      redirect_to user_show_path
    end
  end

end
