source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '>= 5.0.0.rc1', '< 5.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'turbolinks', '~> 5.x'
gem 'jbuilder', '~> 2.0'
gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
end

group :development, :test do
  gem 'byebug'
  gem 'pry-rails'
  gem 'awesome_print'
  gem 'dotenv-rails'
  gem 'rails-controller-testing', git: 'https://github.com/rails/rails-controller-testing'
  gem 'rspec-rails', '~> 3.5.0.beta3'
  gem 'factory_girl_rails'
end

group :test do
  gem 'fuubar', '~> 2.1.0.beta2'
  gem 'shoulda-matchers'
  gem 'rspec-its'
  gem 'webmock'
  gem 'vcr'
end
