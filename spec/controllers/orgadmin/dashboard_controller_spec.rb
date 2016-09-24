require 'rails_helper'

RSpec.describe Orgadmin::DashboardController, type: :controller do
  let(:org) { FactoryGirl.create(:organization) }
  before(:each) { login_user }

  describe 'index > ' do
    context 'users who are not admins of this org > ' do
      it 'will be denied access' do
        expect do
          get :index
        end.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'users who are an org_admin of this org > ' do
      before(:each) { subject.current_user.add_role(:admin, org) }

      it 'will see page' do
        get :index
        expect(response).to be_successful
      end

      it "will not see a current campaign, if they haven't joined one" do
        get :index
        expect(assigns(:organization_campaign)).to be_nil
        expect(assigns(:joined_campaigns)).to be_empty
        expect(assigns(:joinable_campaigns)).to be_empty
        expect(assigns(:organization_campaign_new)).to be_a_new(OrganizationCampaign)
      end

      it 'will see their current campaign' do
        oc = FactoryGirl.create :organization_campaign, organization: org
        get :index
        expect(assigns(:organization_campaign)).to eq oc
        expect(assigns(:joined_campaigns)).to eq [oc.campaign]
      end
    end
  end

  # describe 'switch_current_campaign > ' do
  #   let(:c) { FactoryGirl.create :campaign }
  #   before(:each) do
  #     subject.current_user.add_role(:admin, org)
  #     get :switch_current_campaign, id: org.id, organization_campaign: { campaign_id: c.id }
  #   end

  #   it 'changes session variable for current_campaign ' do
  #     expect(session[:current_campaign]).to eq c.id.to_s
  #   end

  #   it 'redirects to org page ' do
  #     expect(response).to redirect_to organization_path(org.id)
  #   end
  # end
end
