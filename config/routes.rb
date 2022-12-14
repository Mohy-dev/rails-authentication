Rails.application.routes.draw do
  root 'static_pages#home'

  post "sign_up", to: "users#create"
  get "sign_up", to: "users#new"

  post "login", to:"sessions#create"
  delete "logout", to:"sessions#destroy"
  get "login", to:"sessions#new"

  resources :passwords, only: [:create, :edit, :new, :update], param: :password_reset_token

  resources :confirmations, only: [:create, :edit, :new], param: :confirmation_token
end
