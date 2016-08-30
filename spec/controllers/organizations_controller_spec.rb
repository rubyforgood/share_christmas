require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  render_views
  let(:org) { FactoryGirl.create(:organization, name: 'Test Organization') }

  describe 'index' do
    it 'successfully responds' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'show' do
    it 'will see organization information' do
      get :show, id: org.id
      expect(response).to have_http_status(:success)
    end
  end

  describe 'create' do
    let(:org_params) { { name: 'test' } }

    context 'when not logged in' do
      it 'does not add an organization' do
        expect { post :create, organization: org_params }.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'when logged in' do
      before { login_user(admin: true) }

      it 'adds an organization' do
        expect { post :create, organization: org_params }.to change { Organization.count }
      end
    end
  end

  describe 'new' do
    context 'when not logged in' do
      it 'redirects because not authorized' do
        expect { get :new }.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'when logged in' do
      before { login_user(admin: true) }

      it 'successfully renders a page' do
        get :new
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'edit' do
    context 'when not logged in' do
      it 'redirects because not authorized' do
        expect { get :edit, id: org.slug }.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'when logged in' do
      before { login_user(admin: true) }

      it 'successfully renders a page' do
        get :edit, id: org.slug
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'update' do
    let(:org_params) { { name: 'testtesttest' } }

    context 'when not logged in' do
      it 'is not authorized' do
        expect { put :update, id: org.slug, organization: org_params }
          .to raise_error(CanCan::AccessDenied)
      end
    end

    context 'when logged in' do
      before { login_user(admin: true) }

      it 'updates the org' do
        put :update, id: org.slug, organization: org_params
        expect(org.reload.name).to eq('testtesttest')
      end
    end
  end
end
