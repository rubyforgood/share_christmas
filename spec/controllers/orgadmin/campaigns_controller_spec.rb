require 'rails_helper'

RSpec.describe Orgadmin::CampaignsController, type: :controller do
  let(:org) { FactoryGirl.create(:organization) }
  let!(:campaign) { FactoryGirl.create(:campaign) }
  before(:each) { login_user }

  describe 'switch_current_campaign > ' do
    let(:campaign2) { FactoryGirl.create(:campaign) }
    before(:each) do
      subject.current_user.add_role(:admin, org)
      get :switch_current_campaign, organization_campaign: {campaign_id: campaign2.id}
    end

    it 'changes session variable for current_campaign ' do
      expect(session[:current_campaign]).to eq campaign2.id.to_s
    end

    it 'redirects to campaign page ' do
      expect(response).to redirect_to orgadmin_root_path
    end
  end
end
