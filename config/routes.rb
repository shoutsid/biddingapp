Bidding::Application.routes.draw do
  concern :biddable do
    resources :bids
  end

  devise_for :users

  root to: 'items#index'

  resources :items, concerns: :biddable

  resources :categories

  resources :categories, path: '', only: :show do
    resources :items, concerns: :biddable
  end
end
