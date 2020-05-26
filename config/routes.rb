Rails.application.routes.draw do
  get 'tournaments/index'
  get 'tournaments/show'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :tournaments, only: [:index, :show]
end
