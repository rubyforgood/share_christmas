require 'rails_helper'

RSpec.describe OrgAdminsController, type: :controller do
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

      it 'will see current org admins, of which they are one' do
        get :index, organization_id: org.id
        expect(assigns(:admins)).to eq [subject.current_user]
        expect(assigns(:user)).to be_a_new(User)
      end
    end
  end

  describe 'create >' do
    # Could probably do this with FactoryGirl, but whatever
    let(:willy_smith_attr) { { first_name: 'Willy', last_name: 'Smith', email: 'wsmith@gmail.com' } }
    before(:each) { subject.current_user.add_role(:admin, org) }

    it "creates a new user, if a user with that email doesn't exist" do
      expect do
        post :create, organization_id: org.id, user: willy_smith_attr
      end.to change { User.count }.by 1
    end

    it 'uses existing user, if it does exist' do
      # Need password to create a new user from scratch
      willy_smith_attr[:password] = willy_smith_attr[:password_confirmation] = 'BLUGGGGH'
      User.create!(willy_smith_attr)
      expect do
        post :create, organization_id: org.id, user: willy_smith_attr
      end.to_not change { User.count }
    end

    it 'assigns role to user and goes back to org admin list' do
      post :create, organization_id: org.id, user: willy_smith_attr
      ws = User.find_by_email(willy_smith_attr[:email])
      expect(ws).to have_role :admin, org
      expect(response).to redirect_to organization_org_admins_path(org.id)
    end
  end

  describe 'destroy >' do
    it 'removes role from user and goes back to org admin list' do
      # Must do this with a user different than the login user, or we won't
      # be able to redirect back
      willy_smith_attr = { first_name: 'Willy', last_name: 'Smith', email: 'wsmith@gmail.com' }
      subject.current_user.add_role(:admin, org)
      willy_smith_attr[:password] = willy_smith_attr[:password_confirmation] = 'BLUGGGGH'
      ws = User.create!(willy_smith_attr)
      ws.add_role(:admin, org)

      delete :destroy, organization_id: org.id, id: ws.id

      expect(ws).to_not have_role :admin, org
      expect(response).to redirect_to organization_org_admins_path(org.id)
    end
  end
end
