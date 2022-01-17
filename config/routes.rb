require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'sign_up', to: 'users#new'
  get 'logout', to: 'sessions#destroy'
  resources :users, only: [:create, :update]
  resources :order_items, except: [:new ]
  resources :sneakers, only: [:index, :show]
  resources :sessions, only: [:create]
  root to: 'pages#home'
  get 'about', to: "pages#about"
  get 'checkout', to: "pages#checkout"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
