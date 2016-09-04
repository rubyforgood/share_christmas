require 'rails_helper'

RSpec.describe AppealsController, type: :controller do
  let(:oc) { FactoryGirl.create(:organization_campaign) }
  before(:each) { login_user }

  describe 'new >' do
    it 'denormalizes variables for fast lookup' do
      get :new, organization_campaign: oc.id
      expect(assigns(:campaign)).to eq oc.campaign
    end

    it 'constructs a template email for display' do
      get :new, organization_campaign: oc.id
      expect(assigns(:appeal).content).to match organization_campaign_url(oc)
      expect(assigns(:appeal).subject).to eq 'Share Your Christmas 2015'
    end
  end

  describe 'create >' do
    let(:appeal_attr) do
      {
        organization_campaign_id: oc.id,
        subject: 'Share Your Groundhog Day 2016',
        content: 'The groundhog is waiting for you.'
      }
    end

    it 'sends emails' do
      post :create, appeal: appeal_attr
      mail = ActionMailer::Base.deliveries.last
      expect(mail.subject).to eq appeal_attr[:subject]
    end

    it 'redirects to org admin dashboard' do
      post :create, appeal: appeal_attr
      expect(response).to redirect_to organization_path(id: oc.organization.id)
    end
  end
end
