require 'rails_helper'

RSpec.describe Orgadmin::OrganizationCampaignsController, type: :controller do
  before(:each) { login_user }

  describe 'create > ' do
    let(:org) { FactoryGirl.create(:organization) }
    let(:c) { FactoryGirl.create(:campaign) }
    let(:oc_attr) { { organization_id: org.id, campaign_id: c.id } }

    context 'users who are not admins of this org > ' do
      it 'will be denied access' do
        expect do
          post :create, organization_campaign: oc_attr
        end.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'users who are an org_admin of this org > ' do
      before(:each) { subject.current_user.add_role(:admin, org) }

      it 'will create org admin and redirect back to organization' do
        expect do
          post :create, organization_campaign: oc_attr
        end.to change { OrganizationCampaign.count }.by 1
        expect(response).to redirect_to orgadmin_root_path
      end
    end
  end
end
