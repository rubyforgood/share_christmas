class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_org_and_authorize
  layout 'org_admin'

  def index
    @memberships = @org.memberships.includes(:user).order("users.last_name, users.first_name")
  end    

  def new
    @user = User.new
    @membership = Membership.new
  end

  def create
    # Create the user first, but don't duplicate!  Generate a phony password - this will 
    # be overwritten on the user's first login
    nup = new_user_params
    user = User.find_by(email: nup[:email])
    unless user 
      # Create user.
      nup[:password] = nup[:password_confirmation] = ENV['USER_PASSWORD'] 
      user = User.create!(nup.except(:membership))

      # TODO: If send_email is checked, send a reset password email 
    end

    # if user is already a member, don't create another record
    m = Membership.find_by(organization: @org, user: user)
    unless m
      Membership.create!(
        organization: @org, 
        user: user, 
        send_email: nup[:membership][:send_email]
      )
    end
    redirect_to organization_memberships_path(@org.id)
  end

private
  def load_org_and_authorize 
    @org = Organization.friendly.find(params[:organization_id])
    authorize! :admin, @org
  end 

  def new_user_params
    params.require(:user).permit(
      :first_name, :last_name,:email,
      membership: [:send_email]
    )
  end

end