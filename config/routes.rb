Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'

  resources :tournaments, only: [:index, :show]

  resources :earnings, except: :destroy

  resources :expenses, except: :destroy

  resources :my_tournaments, only: [:index, :create]
end
