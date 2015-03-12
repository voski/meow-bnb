Rails.application.routes.draw do
  root 'cats#index'
  resources :cats
  resources :cat_rental_requests, only: [:new, :create] do
    get :approve, on: :member
    get :deny, on: :member
  end
  resource :user
  resource :session
end
