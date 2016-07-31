require 'rails_helper'

RSpec.describe OrganizationCampaignsController, type: :controller do
  before(:each) { login_user }

  describe 'show > ' do
    let(:oc) { FactoryGirl.create(:organization_campaign) }

    it 'stores organizaton campaign particulars in session' do
      get :show, id: oc.id
      expect(session[:organization_name]).to eq 'United Way'
      expect(session[:campaign_name]).to eq 'Share Your Christmas 2015'
    end

    it 'shows recipients and donors for that org campaign' do
      get :show, id: oc.id
      expect(assigns(:donors)).to be_empty
      expect(assigns(:recipients)).to be_empty
      expect(assigns(:match)).to be_a_new(Match)
    end
  end

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
        oc = OrganizationCampaign.first
        expect(response).to redirect_to organization_path(id: oc.organization.id)
      end
    end
  end
end
