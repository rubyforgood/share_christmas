class CampaignsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: [:index, :show]
  layout 'org_admin'

  def index
    @campaigns = Campaign.all
  end

  def show
    @campaign = Campaign.find(params[:id])
    @other_active_campaigns = Campaign.where.not(id: @campaign)
  end

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new(campaign_params)

    if @campaign.save
      flash[:success] = 'Campaign created!'
      redirect_to @campaign
    else
      flash[:alert] = "Couldn't create campaign"
      render :edit
    end
  end

  def edit
    @campaign = Campaign.find(params[:id])
  end

  def update
    @campaign = Campaign.find(params[:id])
    if @campaign.update_attributes(campaign_params)
      flash[:success] = 'Campaign updated!'
      redirect_to @campaign
    else
      flash[:alert] = "Couldn't update"
      render :edit
    end
  end

  def destroy
    @campaign = Campaign.find(params[:id])

    if @campaign.delete
      flash[:success] = "#{@campaign.name} Deleted"
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

  def campaign_params
    params.require(:campaign).permit(:name, :description, :donation_deadline, :reminder_date, :logo)
  end
end
