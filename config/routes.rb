Rails.application.routes.draw do
  devise_for :users

  resources :articles

  namespace :admin do
    resources :users, only: %i[ index update ]
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "home_pages#index"
end
