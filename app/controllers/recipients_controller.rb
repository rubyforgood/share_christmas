class RecipientsController < ApplicationController
  def index
    @grouped_recipients = Recipient.all.group_by(&:recipient_family)
  end

  def show
    @recipient = Recipient.find(params[:id])
  end

  def edit
    @recipient = Recipient.find(params[:id])
  end

  def update
    @recipient = Recipient.find(params[:id])

    if @recipient.update_attributes(recipient_params)
      flash[:success] = 'Recipient updated!'
      redirect_to @recipient
    else
      flash[:error] = "Couldn't update recipient"
      render :edit
    end
  end

  def match
    recipient = Recipient.find(params[:id])
    recipient.update(membership_id: params[:recipient][:membership_id])
    flash[:message] = "Thank you for helping #{recipient.first_name}!"
    redirect_to user_show_path
  end

  def new
    recipient_family = RecipientFamily.find(params[:recipient_family])
    @recipient = recipient_family.recipients.new
  end

  def create
    @recipient = Recipient.new(recipient_params)

    if @recipient.save
      flash[:success] = 'Recipient created!'
      redirect_to @recipient
    else
      flash[:alert] = "Couldn't create recipient"
      render :edit
    end
  end

  def destroy
    @recipient = Recipient.find(params[:id])

    if @recipient.delete
      flash[:success] = "#{@recipient.first_name} Deleted"
      redirect_to recipients_path
    else
      flash[:alert] = "Couldn't delete"
      redirect_to :back
    end
  end

  private

  def recipient_params
    params.
        require(:recipient).
        permit(:organization_campaign_id, :recipient_family_id,
               :first_name, :last_name, :email, :age, :gender, :race, :size,
               :street, :city, :state, :zip_code,
               :wish_list)
  end
end
