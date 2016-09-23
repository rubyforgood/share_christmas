require 'rails_helper'

RSpec.describe Vcadmin::CampaignsController, type: :controller do
  let!(:campaign) { FactoryGirl.create(:campaign) }
  before(:each) { login_user }

  describe 'index > ' do
    context 'users who are not volunteer center admins > ' do
      it 'will not be denied access' do
        get :index
        expect(response).to be_successful
      end
    end
  end

  describe 'show > ' do
    context 'users who are not volunteer center admins > ' do
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

      it 'displays error message if campaign is invalid' do
        expect do
          post :create, campaign: { name: '' }
        end.to_not change { Campaign.count }
        expect(flash[:alert]).to_not be_nil
        expect(response).to render_template :edit
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
        expect(response).to redirect_to [:vcadmin, campaign]
      end

      it 'displays error message if update is invalid' do
        put :update, id: campaign, campaign: { name: '' }
        expect(flash[:alert]).to_not be_nil
        expect(response).to render_template :edit
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
        expect(response).to redirect_to vcadmin_campaigns_path
      end
    end
  end

end
