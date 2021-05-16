Rails.application.routes.draw do
  root 'users#new'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :tasks
  resources :labels
  namespace :admin do
    resources :users
  end
end
