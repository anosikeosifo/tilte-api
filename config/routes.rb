Rails.application.routes.draw do

  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do #this specifies json as the default format for route responses
    devise_for :users
  end
  
  
end
