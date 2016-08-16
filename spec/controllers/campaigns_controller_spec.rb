require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
  let!(:campaign) { FactoryGirl.create(:campaign) }

  before(:each) { login_user }

  describe 'index > ' do
    context 'users who are not admins of this campaign > ' do
      it 'will not be denied access' do
        get :index
        expect(response).to be_successful
      end
    end
  end

  describe 'show > ' do
    context 'users who are not admins of this campaign > ' do
      it 'will not be denied access' do
        get :show, id: campaign
        expect(response).to be_successful
      end
    end
  end

  describe 'new >' do
    context 'with an admin' do
      before(:each) do
        subject.current_user.add_role :admin
      end

      it 'will get a fresh campaign record' do
        get :new
        expect(assigns(:campaign)).to be_a_new(Campaign)
      end
    end

    context 'with not an admin' do
      it 'will raise error' do
        expect do
          get :new
        end.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe 'create >' do
    context 'with an admin' do
      before(:each) { subject.current_user.add_role :admin }

      it 'creates a new use' do
        expect do
          post :create, campaign: FactoryGirl.attributes_for(:campaign)
        end.to change { Campaign.count }.by 1
      end
    end

    context 'with not an admin' do
      it 'will raise error' do
        expect do
          post :create, campaign: FactoryGirl.attributes_for(:campaign)
        end.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe 'edit >' do
    context 'with an admin' do
      before(:each) { subject.current_user.add_role :admin }

      it 'creates a new use' do
        get :edit, id: campaign
        expect(assigns(:campaign)).to eq campaign
      end
    end

    context 'with not an admin' do
      it 'will raise error' do
        expect do
          get :edit, id: campaign
        end.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe 'update >' do
    context 'with not an admin' do
      it 'will raise error' do
        expect do
          put :update, id: campaign, campaign: FactoryGirl.attributes_for(:campaign)
        end.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'with an admin' do
      before(:each) { subject.current_user.add_role :admin }

      it 'updates record' do
        put :update, id: campaign, campaign: FactoryGirl.attributes_for(:campaign)
        expect(response).to redirect_to campaign
      end
    end
  end

  describe 'destroy > ' do
    context 'without admin rights' do
      it 'will raise error' do
        expect do
          delete :destroy, id: campaign
        end.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'with admin rights' do
      before(:each) { subject.current_user.add_role :admin }

      it 'updates record' do
        delete :destroy, id: campaign
        expect(response).to redirect_to campaigns_path
      end
    end
  end

  describe 'switch_current_campaign > ' do
    let(:campaign2) { FactoryGirl.create(:campaign) }
    before(:each) do
      subject.current_user.add_role :admin
      get :switch_current_campaign, id: campaign, campaign: campaign2
    end

    it 'changes session variable for current_campaign ' do
      expect(session[:current_campaign]).to eq campaign2.id.to_s
    end

    it 'redirects to campaign page ' do
      expect(response).to redirect_to campaign_path(campaign2)
    end
  end
end
