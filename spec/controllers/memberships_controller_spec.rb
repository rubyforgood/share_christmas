require 'rails_helper'

RSpec.describe MembershipsController, type: :controller do
  let(:org) { FactoryGirl.create(:organization) }
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
        m = FactoryGirl.create(:membership, organization: org, user: subject.current_user)
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
    let(:willy_smith_attr) do
      {
        first_name: 'Willy', last_name: 'Smith', email: 'wsmith@gmail.com',
        membership: { send_email: true }
      }
    end

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
      ws = User.create!(willy_smith_user_attr)
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
      willy_smith_attr[:password] = willy_smith_attr[:password_confirmation] = 'BLUGGGGH'
      ws = User.create!(willy_smith_user_attr)
      Membership.create!(organization: org, user: ws)

      expect do
        post :create, organization_id: org.id, user: willy_smith_attr
      end.to_not change { Membership.count }
      expect(response).to redirect_to organization_memberships_path(org.id)
    end
  end
end
