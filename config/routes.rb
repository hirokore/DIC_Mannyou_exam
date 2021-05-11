Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :tasks
  namespace :admin do
    resources :users
  end
end
