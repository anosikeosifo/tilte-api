require 'api_constraints'
Rails.application.routes.draw do

  devise_for :users
  # devise_for :users
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do #this specifies json as the default format for route responses
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
    end
    
  end
  
  
end
