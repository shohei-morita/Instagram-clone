Rails.application.routes.draw do
  root 'users#new'
  mount LetterOpenerWeb::Engine, at: %q(/letter_opener) if Rails.env.development?
  resources :users, only: %i(new create show edit update)
  resources :sessions, only: %i(new create destroy)
  resources :favorites, only: %i(create destroy)
  resources :pictures do
    collection do
      post :confirm
    end
  end
end
