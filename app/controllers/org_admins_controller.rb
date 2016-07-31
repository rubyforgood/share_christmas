# OrgAdmins is a sort of virtual model - An Org Admin is a user with a tied OrgAdmin role.
# So there's no OrgAdmin model, and thus no load_and_authorize_resource

class OrgAdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_org_and_authorize
  layout 'org_admin'

  def index
    @admins = User.with_role :admin, @org
    @user = User.new
  end

  def create
    # Create the user first, but don't duplicate!  Generate a phony password - this will
    # be overwritten on the user's first login
    nup = new_user_params
    user = User.find_by(email: nup[:email])
    unless user
      # Create user.
      nup[:password] = nup[:password_confirmation] = ENV['USER_PASSWORD']
      user = User.create!(nup)

      # TODO: Send a combined reset password/org admin email, else send a plain org admin email
    end

    user.add_role(:admin, @org)

    redirect_to organization_org_admins_path(@org.id)
  end

  def destroy
    user = User.find(params[:id])
    user.remove_role(:admin, Organization.find(@org.id))
    redirect_to organization_org_admins_path(@org.id)
  end

  private

  def load_org_and_authorize
    @org = Organization.friendly.find(params[:organization_id])
    authorize! :admin, @org
  end

  def new_user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
