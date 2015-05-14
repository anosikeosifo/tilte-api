require 'api_constraints'
Rails.application.routes.draw do

  get 'comments/flag'

  get 'comments/remove'

  devise_for :users
  # devise_for :users
  namespace :api, defaults: { format: :json } do #this specifies json as the default format for route responses
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:index, :show, :create, :update, :following, :followers] do
        get :followers, on: :member
        get :following, on: :member

        resources :posts, only:[:create]
        resources :comments, only: [:create]
      end


      resources :posts, only:[:index, :update, :show] do
        member do
          post 'remove'
        end
      end


      resources :comments, only: [:index] do
        post :flag, on: :member
        post :remove, on: :member
      end
      
      
      resources :sessions, only: [:create, :destroy]
      resources :relationships, only: [:create, :destroy]
    end
  end
end
