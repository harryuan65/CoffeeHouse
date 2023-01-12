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
  resources :orders do
    collection do
      post :confirm
      get :confirm, to: redirect("carts/current"), as: :back_to_cart
    end
  end
  resources :shipments
  scope controller: :stripe, path: "stripe", as: "stripe" do
    get :checkout
    get :payment_success
    get :payment_cancel
    post :webhook
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
