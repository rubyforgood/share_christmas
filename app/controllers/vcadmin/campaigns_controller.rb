class Vcadmin::CampaignsController < Vcadmin::ApplicationController
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
      redirect_to [:vcadmin, @campaign]
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
      redirect_to [:vcadmin, @campaign]
    else
      flash[:alert] = "Couldn't update"
      render :edit
    end
  end

  def destroy
    @campaign = Campaign.find(params[:id])

    if @campaign.delete
      flash[:success] = "#{@campaign.name} Deleted"
      redirect_to vcadmin_campaigns_path
    else
      flash[:alert] = "Couldn't delete"
      redirect_to :back
    end
  end

  private

  def campaign_params
    params.require(:campaign).permit(:name, :description, :donation_deadline, :reminder_date, :logo)
  end
end
