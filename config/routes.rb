Rails.application.routes.draw do
  devise_for :users

  resources :articles do
    resources :comments do
      get 'new_reply', on: :collection
    end
  end

  namespace :admin do
    resources :users, only: %i[ index update ]
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "home_pages#index"
end
