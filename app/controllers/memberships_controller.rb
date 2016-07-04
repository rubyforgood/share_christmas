class MembershipsController < ApplicationController
  before_action :authenticate_user!
  layout 'org_admin'

  def index
    # TODO: Make sure user has org admin role for this org
    @memberships = Membership.where(search_membership_params)
    @org = Organization.find(search_membership_params[:organization_id])
    @user = User.new
    @membership = Membership.new
  end

  def create
    # Create the user first, but don't duplicate!  Generate a phony password - this will 
    # be overwritten on the user's first login
    mp = new_membership_params
    org_id = mp[:organization_id]
    nup = new_user_params
    user = User.find_by(email: nup[:email])
    unless user 
      # Create user.
      nup[:password] = nup[:password_confirmation] = ENV['USER_PASSWORD'] 
      user = User.create!( nup )

      # TODO: Send a combined reset password/org admin email, else send a plain org admin email
    end

    # Check to see if they have an existing membership for this org.  If so, just update the org_admin flag
    m = Membership.find_by(user_id: user.id, organization_id: org_id)
    if m 
      m.update!(org_admin: mp[:org_admin])
    else 
      mp[:user_id] = user.id
      Membership.create!(mp)
    end

    # Right now, the only place to create members is in Administrator List, so...
    redirect_to memberships_path(organization_id: org_id, org_admin: true)
  end

  def update
    m = Membership.find(params[:id])
    m.update!(update_membership_params)

    # Right now, the only place to create members is in Administrator List, so...
    redirect_to memberships_path(organization_id: m.organization_id, org_admin: true)
  end

private

  def search_membership_params
    params.permit(:organization_id, :org_admin)
  end

  def new_membership_params
    params.require(:membership).permit(:organization_id, :org_admin, :send_email)
  end

  def update_membership_params
    params.require(:membership).permit(:org_admin, :send_email)
  end

  def new_user_params
    params.require(:membership).require(:user).permit(:first_name,:last_name,:email)
  end

end