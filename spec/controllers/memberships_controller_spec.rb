require 'rails_helper'

RSpec.describe MembershipsController, type: :controller do
  let(:org) { FactoryGirl.create(:organization) }
  before(:each) { login_user }

  describe "index > " do
    context "users who are not admins of this org > " do
      it "will be denied access" do
        expect {
          get :index, organization_id: org.id
        }.to raise_error(CanCan::AccessDenied)
      end
    end

    context "users who are an org_admin of this org > " do
      before(:each) { subject.current_user.add_role(:admin, org) }

      it "will see page" do
        get :index, organization_id: org.id
        expect(response).to be_successful
      end

      it "will see current members" do
        m = FactoryGirl.create(:membership, organization: org, user: subject.current_user)
        get :index, organization_id: org.id
        expect(assigns(:memberships).count).to eq 1
      end
    end
  end
end