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

  resource :mail, only: [] do
    resources :appeals, only: [:new, :create]
  end

  resources :campaigns do
    member do
      get :switch_current_campaign
    end
  end

  resources :organizations, only: [:show] do
    resources :org_admins, only: [:index, :create, :destroy]
    resources :memberships
    resources :recipients, only: [:index, :edit, :update]
    resources :import_sessions, only: [:new, :create]
    member do
      get :switch_current_campaign
    end
  end
  resources :organization_campaigns, only: [:show, :create]
  resources :recipients, only: [:index, :update]
  resources :users, only: [:index, :new, :create]
end
