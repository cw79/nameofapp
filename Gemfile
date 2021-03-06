source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Angular for MVC client side 
gem 'angularjs-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# google webfonts
gem 'google-webfonts-rails', '~> 0.0.4'

# gem devise
gem 'devise'

# gem cancancan
gem 'cancancan'

## gem file for Rails 3+, Sinatra, and Merb
gem 'will_paginate', '~> 3.0.5'

# Stripe for payments
gem 'stripe'

# Foldable DOM elements
gem 'oridomi-rails', '~> 1.0'

# Caching resources
gem 'dalli'
gem 'memcachier'

# Redis
gem 'redis-rails'

# NewRelic health monitoring
gem 'newrelic_rpm'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Rspec for testing 
  gem 'rspec-rails', '~> 3.0'
  gem "factory_girl_rails", "~> 4.0"

  # Use sqlite3 as the database for Active Record
	gem 'sqlite3'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Guard for automated testing 
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'spork-rails'
  gem 'guard-spork'

end

group :production do
  gem 'rails_12factor'
	gem 'pg'
end


