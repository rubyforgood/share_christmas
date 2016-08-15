class RecipientFamiliesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: [:index, :show]
  layout 'org_admin'

  def index
    @recipient_families = RecipientFamily.all
  end

  def show
    @recipient_family = RecipientFamily.find(params[:id])
    @other_active_campaigns = RecipientFamily.where.not(id: @recipient_family)
  end

  def new
    @recipient_family = RecipientFamily.new
  end

  def create
    @recipient_family = RecipientFamily.new(recipient_family_params)

    if @recipient_family.save
      flash[:success] = 'Recipient family created!'
      redirect_to @recipient_family
    else
      flash[:alert] = "Couldn't create campaign"
      render :edit
    end
  end

  def edit
    @recipient_family = RecipientFamily.find(params[:id])
  end

  def update
    @recipient_family = RecipientFamily.find(params[:id])
    if @recipient_family.update_attributes(recipient_family_params)
      flash[:success] = 'Recipient family updated!'
      redirect_to @recipient_family
    else
      flash[:alert] = "Couldn't update"
      render :edit
    end
  end

  def destroy
    @recipient_family = RecipientFamily.find(params[:id])

    if @recipient_family.delete
      flash[:success] = "#{@recipient_family.name} Deleted"
      redirect_to campaigns_path
    else
      flash[:alert] = "Couldn't delete"
      redirect_to :back
    end
  end

  def switch_current_campaign
    session[:current_campaign] = params[:campaign]
    redirect_to campaign_path params[:campaign]
  end

  private

  def recipient_family_params
    params.
        require(:recipient_family).
        permit(:contact_last_name, :contact_first_name, :address, :city, :state, :zip, :phone)
  end
end
