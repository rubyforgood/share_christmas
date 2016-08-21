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

  describe 'send_email_form >' do
    let(:oc) { FactoryGirl.create(:organization_campaign) }

    it 'denormalizes variables for fast lookup' do
      get :send_email_form, id: oc.id
      expect(assigns(:campaign)).to eq oc.campaign
    end

    it 'constructs a template email for display' do
      get :send_email_form, id: oc.id
      expect(assigns(:content)).to match organization_campaign_url(oc)
      expect(assigns(:subject)).to eq 'Share Your Christmas 2015'
    end
  end

  describe 'send_email >' do
    let(:oc) { FactoryGirl.create(:organization_campaign) }

    it 'sends emails' do
      post :send_email, id: oc.id, subject: 'Share It', content: 'Hi mom!'
      mail = ActionMailer::Base.deliveries.last
      expect(mail.subject).to eq 'Share It'
    end

    it 'redirects to org admin dashboard' do
      post :send_email, id: oc.id, subject: 'Share It', content: 'Hi mom!'
      expect(response).to redirect_to organization_path(id: oc.organization.id)
    end
  end
end
