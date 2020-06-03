Rails.application.routes.draw do

  get 'dashboard/index'
  devise_for :users
  root to: 'pages#home'

  resources :tournaments, only: [:index, :show] do

    resources :earnings, only: :create
  end


  resources :earnings, except: :destroy do
    patch :create_multiple_expenses, to: 'expenses#create_multiple', as: 'create_multiple_expenses'
  end

  resources :expenses, except: :destroy


  resources :dashboard, only: :index
end
  # get 'tournament/:tournament_id/expenses/new', to: 'tournament_expenses#new', as: :new_tournament_expense
