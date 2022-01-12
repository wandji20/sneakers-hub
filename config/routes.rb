Rails.application.routes.draw do
  resources :users, only: [:create, :update]
  resources :order_items, except: [:new ]
  resources :sneakers, only: [:index, :show]
  root to: 'pages#home'
  get 'about', to: "pages#about"
  get 'checkout', to: "pages#checkout"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
