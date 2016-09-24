module Orgadmin
  class RecipientsController < Orgadmin::ApplicationController
    def index
      @oc = find_organization_campaign
      if params[:matched] == 'true'
        @recipients = @oc.matched_recipients
      elsif params[:matched] == 'false'
        @recipients = @oc.unmatched_recipients
      else
        @recipients = @oc.recipients
      end
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
end
