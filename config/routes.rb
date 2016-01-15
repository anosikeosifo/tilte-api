require 'api_constraints'
Rails.application.routes.draw do

  get 'comments/flag'

  get 'comments/remove'

  devise_for :users
  # devise_for :users
  namespace :api, defaults: { format: :json } do #this specifies json as the default format for route responses
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:index, :show, :create, :update] do
        get :followers, on: :collection
        get :following, on: :collection
        get :favorites, on: :collection
        post :feed, on: :collection
      end


      resources :posts, only:[:create, :index, :update, :show ] do
        post :remove, on: :collection
        post :favorite, on: :collection
      end


      resources :comments, only: [:index, :create] do
        post :flag, on: :collection
        post :remove, on: :collection
      end


      resources :sessions, only: [:create, :destroy]
      resources :relationships, only: [:create] do
        delete :destroy, on: :collection
      end
    end
  end
end
