require 'rails_helper'

RSpec.describe RecipientsController, type: :controller do
  let(:oc) { FactoryGirl.create(:organization_campaign) }
  let(:org) { oc.organization }
  before(:each) { login_user }

  describe 'index > ' do
    context 'users who are not admins of this org > ' do
      it 'will be denied access' do
        expect do
          get :index, organization_campaign: oc.id
        end.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'users who are an org_admin of this org > ' do
      before(:each) do
        subject.current_user.add_role(:admin, org)

        2.times { FactoryGirl.create(:recipient,
                                     organization_campaign: oc) }
        1.times { FactoryGirl.create(:recipient,
                                     organization_campaign: oc).matches.create }
      end

      after(:each) { Match.delete_all; Recipient.delete_all }

      it 'will see page' do
        get :index, organization_campaign: oc.id
        expect(response).to be_successful
      end

      it 'will see matched recipients' do
        get :index, organization_campaign: oc.id, matched: 'true'
        expect(assigns(:recipients).count).to eq 1
      end

      it 'will see unmatched recipients' do
        get :index, organization_campaign: oc.id, matched: 'false'
        expect(assigns(:recipients).count).to eq 2
      end

      it 'will see all recipients' do
        get :index, organization_campaign: oc.id
        expect(assigns(:recipients).count).to eq 3
      end
    end
  end
end
