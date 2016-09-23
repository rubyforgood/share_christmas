require 'rails_helper'

RSpec.describe RecipientsController, type: :controller do
  let(:org) { FactoryGirl.create(:organization) }

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

    it 'returns to user screen' do
      post :update, id: r.id, recipient: { membership_id: m.id }
      expect(flash[:message]).to eq 'Thank you for helping Wesley!'
      expect(response).to redirect_to user_show_path
    end
  end
end