require 'rails_helper'

RSpec.describe Orgadmin::ImportSessionsController, type: :controller do
  let(:org) { FactoryGirl.create(:organization) }
  before(:each) { login_user; subject.current_user.add_role(:admin, org) }

  describe 'new > ' do
    it 'creates a blank import session with defaults' do
      get :new
      expect(assigns[:import_session].merge_mode).to eq 'merge'
    end
  end

  describe 'create > ' do
    it 'merges the membership list in and redirects back to org' do
      ps = {
        merge_mode: 'replace',
        list_file: fixture_file_upload('membership_list.txt', 'text/plain')
      }
      post :create, organization_id: org.id, import_session: ps
      expect(Membership.count).to eq 4
      expect(response).to redirect_to orgadmin_root_path
    end
  end
end
