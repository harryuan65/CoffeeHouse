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
  resources :carts do
    collection do
      get :current
      post :check_out
    end
  end
  resources :cart_items
  resources :orders
  resources :shipments
  resources :stripe, only: [:create] do
    collection do
      get :payment_success
      get :payment_cancel
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
