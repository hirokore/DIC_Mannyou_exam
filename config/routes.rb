Rails.application.routes.draw do
  get 'labels/new'
  root 'users#new'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :tasks
  namespace :admin do
    resources :users
  end
end
