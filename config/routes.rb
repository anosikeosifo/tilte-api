require 'api_constraints'
Rails.application.routes.draw do
  devise_for :users
  # devise_for :users
  namespace :api, defaults: { format: :json } do #this specifies json as the default format for route responses
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :events, only: [:index, :create, :update, :show] do
        get :trending, on: :collection
      end

      resources :event_categories, only: [:create, :show, :update, :delete] do
        get :home, on: :collection
      end

      resources :users, only: [:index, :show, :create, :update] do
        get :followers, on: :collection
        get :following, on: :collection
        get :favorites, on: :collection
        get :status, on: :collection
        post :contact_suggestions, on: :collection
        post :feed, on: :collection
      end

      resources :posts, only:[:create, :index, :update, :show ] do
        post :remove, on: :collection
        post :favorite, on: :collection
        post :repost, on: :collection

        resources :comments, only: [:index]
      end

      resources :comments, only: [:create] do
        post :flag, on: :collection
        post :remove, on: :collection
      end

      resources :sessions, only: [:create, :destroy]
      resources :omniauth_sessions, only: [:create]
      resources :relationships, only: [:create] do
        delete :destroy, on: :collection
      end
    end
  end
end
