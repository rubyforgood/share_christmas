class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_org_and_authorize
  layout 'org_admin'

  def index
    @memberships = @org.memberships.includes(:user).order('users.last_name, users.first_name')
  end

  def new
    @user = User.new
    @membership = Membership.new
  end

  def create
    # Create the user first, but don't duplicate!  Generate a phony password - this will
    # be overwritten on the user's first login
    user = User.find_by(email: new_user_params[:email])
    create_user_for_membership unless user
    membership = Membership.find_by(organization: @org, user: user)
    unless membership
      Membership.create!(
        organization: @org, user: user, send_email: new_user_params[:membership][:send_email]
      )
    end
    redirect_to organization_memberships_path(@org.id)
  end

  private

  def create_user_for_membership
    something = new_user_params.merge(
      password: ENV['USER_PASSWORD'],
      password_confirmation: ENV['USER_PASSWORD']
    )
    # TODO: If send_email is checked, send a reset password email
    User.create!(something.except(:membership))
  end

  def load_org_and_authorize
    @org = Organization.friendly.find(params[:organization_id])
    authorize! :admin, @org
  end

  def new_user_params
    params.require(:user).permit(
      :first_name, :last_name, :email,
      membership: [:send_email]
    )
  end
end
