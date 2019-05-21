source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.18', '< 0.5'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# Please add the following to your Gemfile to avoid polling for changes:
#    gem 'wdm', '>= 0.1.0' if Gem.win_platform?
#  Please add the following to your Gemfile to avoid polling for changes:
#    gem 'wdm', '>= 0.1.0' if Gem.win_platform?
# A server is already running. Check D:/rails_projects/task-manager-rails/tmp/pids/server.pid.
gem 'wdm', '>= 0.1.0'

#gem 'bcrypt', '~> 3.1', '>= 3.1.12'

# para criar os models
gem 'devise'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.5'
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'factory_girl_rails'
  gem 'faker'
end

# gem "spring", group: :development

# gem 'spring-commands-rspec', group: :development

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
#  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec' # acelera tarefas no terminal
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# gem 'active_model_serializers', '~> 0.10.0'
# 
gem 'active_model_serializers', '0.10.9'

gem 'ransack'

gem 'omniauth'

gem 'devise_token_auth'

# instalando a gem 'devise_token_auth' no projeto
# User = nome do model
# auth = nome do prefixo da rota. Pode ser qualquer nome
# Esses dois parametros estão seguindo o padrão da gem
# User auth
# rails g devise_token_auth:install User auth