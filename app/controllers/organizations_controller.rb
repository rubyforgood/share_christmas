class OrganizationsController < ApplicationController
  load_and_authorize_resource param_method: :organization_attributes,
                              find_by: :slug,
                              except: [:show, :index]

  layout 'org_admin'

  def index
    @organizations = Organization.alphabetical.paginate(page: params[:page])
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_attributes)
    if @organization.save
      redirect_to @organization, notice: "#{@organization.name} was successfully added!"
    else
      render 'new'
    end
  end

  def edit
    @organization = Organization.friendly.find(params[:id])
  end

  def update
    @organization = Organization.friendly.find(params[:id])
    if @organization.update_attributes(organization_attributes)
      redirect_to @organization, notice: "#{@organization.name} was successfully updated!"
    else
      render 'edit'
    end
  end

  def show
    @organization = Organization.friendly.find(params[:id])
  end

  def switch_current_campaign
    session[:current_campaign] = params[:organization_campaign][:campaign_id]
    redirect_to organization_path(params[:id])
  end

  private

  def find_organization_campaign
    session[:current_campaign] ||= @org.current_campaign.nil? ? nil : @org.current_campaign.id
    return nil if session[:current_campaign].nil?
    OrganizationCampaign.find_by_organization_id_and_campaign_id(
      @org.id,
      session[:current_campaign]
    )
  end

  def organization_attributes
    params.require(:organization).permit(:name, :description, :url)
  end
end
