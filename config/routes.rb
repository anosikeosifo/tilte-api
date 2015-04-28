require 'api_constraints'
Rails.application.routes.draw do

  get 'relationships/create'

  get 'relationships/destroy'

  get 'create/destroy'

  devise_for :users
  # devise_for :users
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do #this specifies json as the default format for route responses
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:index, :show, :create, :update] do
        member do
          get :followers, :following 
        end
      end
      resources :sessions, only: [:create, :destroy]
      resources :relationships, only: [:create, :destroy]
    end
  end
end
