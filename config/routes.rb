# frozen_string_literal: true

Rails.application.routes.draw do
  ## API Routes
  mount_devise_token_auth_for 'User', at: 'users', controllers: {
    registrations: 'api/v1/users/registrations',
    sessions: 'api/v1/users/sessions',
    invitations: 'api/v1/users/invitations'
  }

  namespace :api do
    namespace :v1 do
      get 'companies/:company_slug/landing_page', to: 'landing_pages#show'
      get '/dashboard', to: 'users#dashboard'

      resources :companies, only: [:index] do
        resources :company_programs, only: %i[index show]
      end
    end
  end
  ## -----------------------------------

  ## React routes
  get '*path', to: 'react#index', constraints: lambda { |req|
    !(req.path.include?('active_storage') || req.path.include?('admin') || req.path.include?('api') || req.path.include?('invitation'))
  }
  ## -----------------------------------

  ## Rails routes
  root to: 'react#index'
  # devise_for :users, controllers: { invitations: 'users/invitations' }
  ## -----------------------------------

  # Admin routes
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  ## ----------------------------------
end
