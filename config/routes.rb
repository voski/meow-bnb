Rails.application.routes.draw do
  root 'cats#index'
  resources :cats
  resources :cat_rental_requests, only: [:new, :create]
  resource :user
  resource :session
end
