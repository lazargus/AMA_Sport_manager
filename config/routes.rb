Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'

  resources :tournaments, only: [:index, :show] do

    resources :earnings, only: :create
  end


  resources :earnings, except: [:destroy]

  resources :expenses, except: :destroy

  resources :my_tournaments, only: [:index, :create]
  get 'tournament/:tournament_id/expenses/new', to: 'tournament_expenses#new', as: :new_tournament_expense
end
