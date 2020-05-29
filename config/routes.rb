Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'

  resources :tournaments, only: [:index, :show] do
    resources :earnings, only: :create
  end

  resources :earnings, except: [:destroy, :create]

  resources :expenses, except: :destroy

  resources :my_tournaments, only: [:index, :create]
end
