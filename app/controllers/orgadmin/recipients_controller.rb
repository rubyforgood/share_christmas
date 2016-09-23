class Orgadmin::RecipientsController < Orgadmin::ApplicationController
  def index
    @oc = find_organization_campaign
    @recipients = @oc.recipients
  end

  def edit
    @user = User.new
    @membership = Membership.new
    @recipient = Recipient.find(params[:id])
    @memberships = @org.memberships_sorted_by_name
  end

  def update
    recipient = Recipient.find(params[:id])
    recipient.update(membership_id: params[:recipient][:membership_id])
    redirect_to orgadmin_recipients_path
  end
end
