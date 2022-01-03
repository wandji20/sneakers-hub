Rails.application.routes.draw do
  resources :sneakers, only: [:index, :show]
  root to: 'pages#home'
  get 'pages/about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
