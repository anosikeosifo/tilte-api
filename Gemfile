source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.10'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

gem 'rack-cors', :require => 'rack/cors'
gem 'mysql2', '0.3.18'
gem 'pry-rails'


group :development do
  gem 'bullet'
end

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development


# Use unicorn as the app server
# gem 'unicorn'
# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'devise' #authentication and user management
gem 'kaminari' #pagination
gem 'figaro'
gem 'fog'
gem 'carrierwave'
gem 'carrierwave-base64'
gem 'unf'




group :development, :test, :production do
  gem 'factory_girl_rails'
  gem 'ffaker'
end


group :test do
  gem 'rspec-rails', '~>3.0'
  gem 'shoulda-matchers'
  gem 'shoulda'
  gem 'email_spec'
end


#gem testing
gem 'compass-rails'
gem 'furatto'
gem 'font-awesome-rails'
gem 'simple_form'

#json serializatoin
gem 'active_model_serializers', '~> 0.8.3'

gem 'passenger',                              '~> 5.0.0.beta1'

group :development do
    gem 'capistrano',         require: false
    gem 'capistrano-rvm',     require: false
    gem 'capistrano-rails',   require: false
    gem 'capistrano-bundler', require: false
    # gem 'capistrano3-puma',   require: false
end

group :production do
  gem 'pg' #adds the postgres gem
  gem 'rails_12factor'
end
