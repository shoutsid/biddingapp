Bidding::Application.routes.draw do
  mount Resque::Server, :at => "/resque"

  concern :biddable do
    resources :bids
  end

  namespace :events do
    get :not_closed_items
    get :all_bids
  end

  devise_for :users

  root to: 'categories#index'

  resources :categories, path: '' do
    resources :items, concerns: :biddable
  end
end
