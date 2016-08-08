source 'https://rubygems.org'

# TODO: update to 2.3.1
ruby '2.3.0'

gem 'autoprefixer-rails'
gem 'aws-sdk', '< 2.0'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'cancancan'
gem 'coffee-rails', '~> 4.1.0'
gem 'devise'
gem 'dotenv-rails'
gem 'friendly_id', '~> 5.1.0'
gem 'jbuilder', '~> 2.0'
gem 'jquery-rails'
gem 'pg', '~> 0.18.4'
gem 'puma'
gem 'paperclip'
gem 'rails', '4.2.6'
gem 'rails-erd'
gem 'rolify'
gem 'sass-rails', '~> 5.0'
gem 'tinymce-rails', github: 'spohlenz/tinymce-rails'
gem 'uglifier', '>= 1.3.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'factory_girl_rails'
  gem 'pry-awesome_print'
  gem 'pry-highlight'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

group :test do
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'database_cleaner'
  gem 'poltergeist'
  gem 'shoulda-matchers', require: false
  gem 'simplecov', require: false
  gem 'timecop'
end

group :production do
  gem 'rails_12factor'
end
