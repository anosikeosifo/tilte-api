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
      end


      resources :posts, only:[:create,  :index, :update, :show ] do
        post :remove, on: :member
        post :like, on: :member
      end


      resources :comments, only: [:index, :create] do
        post :flag, on: :member
        post :remove, on: :member
      end


      resources :sessions, only: [:create, :destroy]
      resources :relationships, only: [:create, :destroy]
    end
  end
end
