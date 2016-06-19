Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords'}

  root 'pages#home'
  get "users/profile", to: "users#show", as: "user_show"

  get 'users/styleguide' => 'users#styleguide', as: :signup

  resources :organization_campaigns, only: :show
  resources :matches, only: :create
end
