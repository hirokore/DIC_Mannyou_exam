Rails.application.routes.draw do
  get 'users/new'
  get 'users/index'
  get 'users/edit'
  root 'tasks#index'
  resources :tasks
end
