Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stock', to: 'stocks#search'
  get 'my_friends', to: 'friendships#my_friends'
  get 'search_friends', to: 'friendships#search'
  resources :friendships, only: [:create, :destroy]
  resources :users, only: [:show]
end
