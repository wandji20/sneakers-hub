require 'sidekiq/web'
Rails.application.routes.draw do
  resources :orders, only: [:create]
  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'sign_up', to: 'users#new'
  delete 'logout', to: 'sessions#destroy'
  resources :users, only: [:create, :update]
  resources :order_items, except: [:new ]
  resources :sneakers, only: [:index, :show]
  resources :sessions, only: [:create]
  resources :brands, only: :index
  resources :genders, only: :index
  root to: 'pages#home'
  get 'about', to: "pages#about"
  post 'checkout', to: "pages#checkout"
  get 'shipping', to: 'pages#shipping'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
