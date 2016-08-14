Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  root 'pages#home'
  get 'users/profile', to: 'users#show', as: 'user_show'

  get 'users/styleguide' => 'users#styleguide', as: :signup

  resources :matches, only: [:new, :create, :destroy]

  resources :campaigns do
    member do
      get :switch_current_campaign
    end
  end

  resources :organizations, only: [:show] do
    resources :org_admins, only: [:index, :create, :destroy]
    resources :memberships
    member do
      get :switch_current_campaign
      get :import_emails_form
      post :import_emails_form_page2
    end
  end
  resources :organization_campaigns, only: [:show, :create] do
    member do
      get :send_email_form
    end
  end
  resources :recipients, only: [:index, :update]
  resources :users, only: [:index, :new, :create]
end
