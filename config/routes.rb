Rails.application.routes.draw do
  root 'users#new'
  resources :users, only: %i(new create show)
  resources :sessions, only: %i(new create destroy)
  resources :pictures do
    collection do
      post :confirm
    end
  end
end
