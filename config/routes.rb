Bidding::Application.routes.draw do
  devise_for :users
  root to: 'items#index'

  resources :items do
    resources :bids
  end
end
