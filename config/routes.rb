Bidding::Application.routes.draw do
  concern :biddable do
    resources :bids
  end

  devise_for :users

  root to: 'categories#index'

  resources :categories, path: '' do
    get :time_left
    resources :items, concerns: :biddable do
      get :time_left
    end
  end
end
