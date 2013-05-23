Bidding::Application.routes.draw do

  concern :biddable do
    resources :bids
  end

  devise_for :users

  namespace :events do
    get :not_closed_items
    get :all_bids
    get :users_balance
  end
  
  devise_for :admins, path: '/admin'
  authenticate :admin do
    namespace :admin do
      get '/', to: 'dashboard#index'
      get 'resque-dashboard', to: 'dashboard#resque', as: 'dashboard_resque'
      mount Resque::Server, at: 'resque'
      resources :categories, except: :show
    end
  end

  root to: 'categories#index'

  resources :categories, path: '' do
    resources :items, concerns: :biddable
  end
end
