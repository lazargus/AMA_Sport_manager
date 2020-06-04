Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'

  resources :tournaments, only: [:index, :show] do

    resources :earnings, only: :create
  end


  resources :earnings, except: :destroy do
    patch :create_multiple_expenses, to: 'expenses#create_multiple', as: 'create_multiple_expenses'

    collection do
      get :my_earnings
    end
  end

  resources :expenses, except: :destroy do
    collection do
      get :donut
    end
  end

  resources :dashboard, only: :index
  resources :users, only: [:show, :edit, :update]
end
  # get 'tournament/:tournament_id/expenses/new', to: 'tournament_expenses#new', as: :new_tournament_expense
