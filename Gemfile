source 'https://rubygems.org'

gem 'rails', '3.2.8'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'
gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
gem 'activeadmin'
gem 'kaminari'
gem 'bootstrap-kaminari-views'
gem 'gmaps4rails'
gem 'state_machine'
gem 'simple_form'
gem 'strong_parameters', :git => "git://github.com/rails/strong_parameters.git"
gem 'ayah_integration'
gem "rails-settings-cached"
gem 'rinku', :require => 'rails_rinku'
gem 'gabba'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use thin as the dev server
group :development do
  unless RUBY_PLATFORM =~ /win32/ 
    gem 'thin'
  end
end

# Use unicorn as the app server 
group :staging, :production do
  gem 'unicorn'
end

# Deploy with Capistrano
group :development do
  gem 'capistrano', '2.13.5'
  gem 'capistrano-ext'
  gem 'capistrano_colors'
end

# To use debugger
# gem 'debugger'
