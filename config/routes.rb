Rails.application.routes.draw do
  get 'sessions/new'
  root 'users#new'
  resources :users, only: [:new, :create, :show]
end
