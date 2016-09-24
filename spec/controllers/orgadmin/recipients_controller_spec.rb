require 'rails_helper'

RSpec.describe Orgadmin::RecipientsController, type: :controller do
  let(:org) { FactoryGirl.create(:organization) }
  before(:each) do
    login_user
    subject.current_user.add_role(:admin, org)
  end

  describe 'index >' do
    let(:oc) { FactoryGirl.create(:organization_campaign, organization: org) }
    let(:rf) { FactoryGirl.create(:recipient_family, organization_campaign: oc) }
    let!(:recipient) {  }
    before(:each) do 
      subject.current_user.add_role(:admin, org)
      2.times { FactoryGirl.create(:recipient, recipient_family: rf) }
      m = FactoryGirl.create(:membership, user: subject.current_user, organization: org)
      FactoryGirl.create(:recipient, recipient_family: rf, membership: m)
    end

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

  describe 'edit >' do
    let(:r) { FactoryGirl.create(:recipient) }

    it 'loads recipient record, and members of org' do
      FactoryGirl.create(:membership, organization: org, user: subject.current_user)

      get :edit, organization_id: org.id, id: r.id
      expect(assigns(:recipient)).to eq r
      expect(assigns(:memberships).count).to eq 1
    end

    it 'constructs blank objects top optionally create new member' do
      get :edit, organization_id: org.id, id: r.id
      expect(assigns(:user)).to be_a_new(User)
      expect(assigns(:membership)).to be_a_new(Membership)
    end
  end

  describe 'update >' do
    let(:r) { FactoryGirl.create(:recipient) }
    let(:alternate_user) do
      FactoryGirl.create(:user, email: 'someoneelse@admin.org', reset_password_token: 'None')
    end
    let(:m) { FactoryGirl.create(:membership, user: alternate_user) }

    it 'updates recipient record' do
      expect(r.membership_id).to_not eq m.id
      post :update, id: r.id, recipient: { membership_id: m.id }
      r.reload
      expect(r.membership_id).to eq m.id
    end

    it 'returns to organization screen, if that\'s where it started from' do
      post :update, id: r.id, recipient: { membership_id: m.id }, organization_id: org.id
      expect(response).to redirect_to orgadmin_recipients_path
    end
  end
end
