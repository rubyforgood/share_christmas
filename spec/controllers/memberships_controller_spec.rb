require 'rails_helper'

RSpec.describe MembershipsController, type: :controller do
  let(:org) { FactoryGirl.create(:organization) }
  let(:willy_smith_attr) do
    {
      first_name: 'Willy', last_name: 'Smith', email: 'wsmith@gmail.com',
      membership: { send_email: true }
    }
  end

  before(:each) { login_user }

  describe 'index > ' do
    context 'users who are not admins of this org > ' do
      it 'will be denied access' do
        expect do
          get :index, organization_id: org.id
        end.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'users who are an org_admin of this org > ' do
      before(:each) { subject.current_user.add_role(:admin, org) }

      it 'will see page' do
        get :index, organization_id: org.id
        expect(response).to be_successful
      end

      it 'will see current members' do
        FactoryGirl.create(:membership, organization: org, user: subject.current_user)
        get :index, organization_id: org.id
        expect(assigns(:memberships).count).to eq 1
      end
    end
  end

  describe 'new >' do
    it 'will get a fresh user and membership record' do
      subject.current_user.add_role(:admin, org)

      get :new, organization_id: org.id
      expect(assigns(:user)).to be_a_new(User)
      expect(assigns(:membership)).to be_a_new(Membership)
    end
  end

  describe 'create >' do
    let(:willy_smith_user_attr) { willy_smith_attr.except(:membership) }
    before(:each) { subject.current_user.add_role(:admin, org) }

    it "creates a new user, if a user with that email doesn't exist" do
      expect do
        post :create, organization_id: org.id, user: willy_smith_attr
      end.to change { User.count }.by 1
    end

    it 'uses existing user, if it does exist' do
      # Need password to create a new user from scratch
      willy_smith_attr[:password] = willy_smith_attr[:password_confirmation] = 'BLUGGGGH'
      User.create!(willy_smith_user_attr)
      expect do
        post :create, organization_id: org.id, user: willy_smith_attr
      end.to_not change { User.count }
    end

    it "creates a membership, if it doesn't exist" do
      expect do
        post :create, organization_id: org.id, user: willy_smith_attr
      end.to change { Membership.count }.by 1
      expect(response).to redirect_to organization_memberships_path(org.id)
    end

    it "doesn't create a membership, if it already exists" do
      willy_smith_user_attr[:password] = willy_smith_user_attr[:password_confirmation] = 'BLUGGGGH'
      ws = User.create!(willy_smith_user_attr)
      Membership.create!(organization: org, user: ws)

      expect do
        post :create, organization_id: org.id, user: willy_smith_attr
      end.to_not change { Membership.count }
      expect(response).to redirect_to organization_memberships_path(org.id)
    end
  end

  describe 'edit >' do
    it 'will look up user and membership record' do
      subject.current_user.add_role(:admin, org)
      m = FactoryGirl.create(:membership, user: subject.current_user)

      get :edit, organization_id: org.id, id: m.id
      expect(assigns(:user)).to eq m.user
      expect(assigns(:membership)).to eq m
    end
  end

  describe 'update >' do
    # This literally changes the logged-in user's record underneath, but
    # there's no real problem with that.
    let(:m) { FactoryGirl.create(:membership, user: subject.current_user) }
    let(:willy_smith_user_attr) { willy_smith_attr.except(:membership) }
    before(:each) { subject.current_user.add_role(:admin, org) }

    it 'does not allow an edit to produce a duplicate email' do
      # Create a Willy Smith user to conflict with the edit
      willy_smith_attr[:password] = willy_smith_attr[:password_confirmation] = 'BLUGGGGH'
      User.create!(willy_smith_user_attr)
      patch :update, organization_id: org.id, id: m.id, user: willy_smith_attr
      expect(flash[:alert]).to_not be_empty
    end

    it 'updates user' do
      patch :update, organization_id: org.id, id: m.id, user: willy_smith_attr
      user = User.first
      expect(user.first_name).to eq 'Willy'
    end

    it 'updates membership and redirects back to member list' do
      patch :update, organization_id: org.id, id: m.id, user: willy_smith_attr
      membership = Membership.first
      expect(membership.send_email).to be_truthy
      expect(flash[:alert]).to be_nil
      expect(response).to redirect_to organization_memberships_path(org.id)
    end
  end
end
