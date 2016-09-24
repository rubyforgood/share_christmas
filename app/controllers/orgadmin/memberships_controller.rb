module Orgadmin
  class MembershipsController < Orgadmin::ApplicationController
    def index
      @memberships = @org.memberships_sorted_by_name
    end

    def new
      @user = User.new
      @membership = Membership.new
    end

    def create
      # Create the user first, but don't duplicate!  Generate a phony password - this will
      # be overwritten on the user's first login
      user = User.find_by(email: user_params[:email]) || create_user_for_membership
      membership =
        Membership.find_by(organization: @org, user: user) ||
        Membership.create!(
          organization: @org, user: user, send_email: user_params[:membership][:send_email]
        )
      # If there's also a recipient, match with that recipient
      if params[:recipient_id]
        recipient = Recipient.find(params[:recipient_id])
        recipient.update!(membership: membership)
        redirect_to orgadmin_recipients_path
      else
        redirect_to orgadmin_memberships_path
      end
    end

    def edit
      @membership = Membership.find(params[:id])
      @user = @membership.user
    end

    def update
      # Don't allow duplicate email if the email has been changed
      membership = Membership.find(params[:id])
      membership.update(user_params[:membership])
      flash[:alert] = update_user(membership)
      redirect_to orgadmin_memberships_path
    end

    def destroy
      membership = Membership.find(params[:id])
      membership.destroy!
      redirect_to orgadmin_memberships_path
    end

    private

    def create_user_for_membership
      something = user_params.merge(
        password: ENV['USER_PASSWORD'],
        password_confirmation: ENV['USER_PASSWORD']
      )
      # TODO: If send_email is checked, send a reset password email
      User.create!(something.except(:membership))
    end

    def update_user(membership)
      user = membership.user
      user.update(user_params.except(:membership))
      user.valid? ? nil : user.errors.full_messages.to_sentence
    end

    def user_params
      params.require(:user).permit(
        :first_name, :last_name, :email,
        membership: [:send_email]
      )
    end
  end
end
