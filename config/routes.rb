Bidding::Application.routes.draw do

  concern :biddable do
    resources :bids
  end

  devise_for :users

  namespace :events do
    get :time_left
    get :updates
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

  root to: 'home#index'

  resources :categories, path: '' do
    resources :items, concerns: :biddable
  end
end
