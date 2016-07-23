require 'rails_helper'

RSpec.describe MatchesController, type: :controller do
  before(:each) { login_user }

  describe 'create >' do
    context "from a member belonging to org of the recipient's org campaign >" do
      let(:oc) { FactoryGirl.create :organization_campaign }
      let(:r) { FactoryGirl.create :recipient, organization_campaign: oc }
      let!(:m) { FactoryGirl.create :membership, organization: oc.organization, user: subject.current_user }

      it 'creates a match' do
        expect do
          post :create, match: { recipient_id: r.id }
        end.to change { Match.count }.by 1
      end

      it 'redirects back to user controller' do
        post :create, match: { recipient_id: r.id }
        expect(response).to redirect_to user_show_path
      end
    end

    context "from a user who's not a member of the recipient's org campaign >" do
      let(:oc) { FactoryGirl.create :organization_campaign }
      let(:r) { FactoryGirl.create :recipient, organization_campaign: oc }

      it "doesn't create the match" do
        expect do
          post :create, match: { recipient_id: r.id }
        end.to_not change { Match.count }
      end

      it 'redirects back to root' do
        post :create, match: { recipient_id: r.id }
        expect(response).to redirect_to root_path
      end
    end
  end
end
