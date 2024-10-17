#!/usr/bin/env bash
set -o errexit

# Установка зависимостей Ruby и JavaScript
echo "Installing Ruby gems and JavaScript packages..."
bundle install --jobs 4 --retry 3
yarn install

# Предварительная компиляция ассетов
echo "Precompiling assets..."
bundle exec rake assets:precompile RAILS_ENV=production

# Удаление и создание базы данных
echo "Dropping and recreating the database..."
bundle exec rake db:drop RAILS_ENV=production || true  # Используем || true, чтобы игнорировать ошибку, если база данных не существует
bundle exec rake db:create RAILS_ENV=production
bundle exec rake db:migrate RAILS_ENV=production
bundlt exec rails db:seed
bundle exec rails action_text:install RAILS_ENV=production 


echo "Build completed successfully!"
