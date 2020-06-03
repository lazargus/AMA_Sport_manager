Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'

  resources :tournaments, only: [:index, :show] do

    resources :earnings, only: :create
  end


  resources :earnings, except: :destroy

  resources :expenses, except: :destroy do
    collection do
      get :donut
    end
  end

  resources :dashboard, only: :index

end
