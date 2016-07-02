Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords'}

  root 'pages#home'
  get "users/profile", to: "users#show", as: "user_show"

  get 'users/styleguide' => 'users#styleguide', as: :signup

  resources :memberships, only: [:index, :new, :create, :edit, :update, :delete]
  resources :matches, only: [:new, :create, :delete]
  resources :organizations, only: [:show] do
    member do
      get :admins
      get :new_admin
      get :switch_current_campaign
      get :import_emails_form
      post :import_emails_form_page2
    end
  end
  resources :organization_campaigns, only: [:show,:create] do
    member do
      get :send_email_form
      get :unmatched
      get :unmatched_tags
      get :matched
      get :match_form
    end
  end
end
