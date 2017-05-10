source 'https://rubygems.org'
ruby '2.3.0'

gem 'rails', '~> 5.0.2'
gem 'puma', '~> 3.0'

# Database
gem 'pg', '~> 0.19.0'

# JSON
gem 'jbuilder', '~> 2.6.1'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Debug
  gem 'jazz_fingers', '~> 4.0.1'

  # Tests
  gem 'rspec-rails'
  gem 'guard-rspec', '~> 4.2.10', require: false

  # Fake data generator
  gem 'faker', '~> 1.6.6'
end

group :development do
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner', '~> 1.5.3'
  gem 'factory_girl_rails', '~> 4.7.0'
  gem 'shoulda-matchers', '~> 3.1.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
