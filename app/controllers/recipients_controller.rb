class RecipientsController < ApplicationController
  def update
    recipient = Recipient.find(params[:id])
    recipient.update(membership_id: params[:recipient][:membership_id])
    flash[:message] = "Thank you for helping #{recipient.first_name}!"
    redirect_to user_show_path
  end
end
