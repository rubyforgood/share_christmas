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
end
