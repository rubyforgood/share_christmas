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
  resources :organization_campaigns, only: [:show]
  resources :recipients, only: [:index, :update]
  resources :users, only: [:index, :new, :create]

  namespace :orgadmin do
    root to: 'dashboard#index', via: 'get'
    resources :dashboard, only: [:index]
    resources :campaigns do
      collection do
        get :switch_current_campaign
      end
    end
    resources :import_sessions, only: [:new, :create]
    resource :mail, only: [] do
      resources :appeals, only: [:new, :create]
    end
    resources :memberships
    resources :org_admins, only: [:index, :create, :destroy]
    resources :organization_campaigns, only: [:create]
    resources :recipients, only: [:index, :edit, :update]
  end

  namespace :vcadmin do
    root to: 'dashboard#index', via: 'get'
    resources :campaigns do
      collection do
        get :switch_current_campaign
      end
    end
  end

end
