# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"
  devise_for :users, controllers: {
    confirmations: "users/confirmations",
    passwords: "users/passwords",
    registrations: "users/registrations",
    sessions: "users/sessions"
    # omniauth_callbacks: 'users/omniauth_callbacks',
    # unlocks: 'users/unlocks'
  }
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
