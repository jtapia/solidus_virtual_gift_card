# frozen_string_literal: true

source 'https://rubygems.org'

branch = ENV.fetch('SOLIDUS_BRANCH', 'master')
gem 'solidus', github: 'solidusio/solidus', branch: branch
gem 'solidus_auth_devise'

if ENV['DB'] == 'mysql'
  gem 'mysql2', '~> 0.4.10'
else
  gem 'pg', '~> 0.21'
end

gem 'rails-controller-testing' if branch == 'master' || branch >= 'v2.0'

group :test do
  gem 'factory_bot', (branch < 'v2.5' ? '4.10.0' : '> 4.10.0')
end

group :development, :test do
  gem 'pry-rails'
end

gemspec
