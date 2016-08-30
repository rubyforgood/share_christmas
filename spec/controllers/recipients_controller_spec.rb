require 'rails_helper'

RSpec.describe RecipientsController, type: :controller do
  let!(:org) { FactoryGirl.create(:organization, name: 'Boy Scouts') }
  let!(:oc) { FactoryGirl.create(:organization_campaign, organization: org) }
  before(:each) { login_user }

  describe 'index >' do
    let(:oc) { FactoryGirl.create(:organization_campaign, organization: org) }
    let!(:recipient) { FactoryGirl.create(:recipient, organization_campaign: oc) }
    before(:each) { subject.current_user.add_role(:admin, org) }

    it 'loads recipients for organization campaign' do
      get :index, organization_id: org.id
      expect(assigns(:recipients)).to eq [recipient]
    end
  end

  describe 'edit >' do
    let(:r) { FactoryGirl.create(:recipient, organization_campaign: oc) }
    before(:each) { subject.current_user.add_role(:admin, org) }

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
    let(:r) { FactoryGirl.create(:recipient, organization_campaign: oc) }
    let(:alternate_user) { FactoryGirl.create(:user, email: 'someoneelse@admin.org', reset_password_token: 'None') }
    let(:m) { FactoryGirl.create(:membership, user: alternate_user, organization: org) }

    it 'updates recipient record' do
      expect(r.membership_id).to_not eq m.id
      post :update, id: r.id, recipient: { membership_id: m.id }
      r.reload
      expect(r.membership_id).to eq m.id
    end

    it 'returns to user screen' do
      post :update, id: r.id, recipient: { membership_id: m.id }
      expect(flash[:message]).to eq 'Thank you for helping Wesley!'
      expect(response).to redirect_to user_show_path
    end

    it 'returns to organization screen, if that\'s where it started from' do
      post :update, id: r.id, recipient: { membership_id: m.id }, organization_id: org.id
      expect(response).to redirect_to organization_recipients_path(org)
    end
  end
end
