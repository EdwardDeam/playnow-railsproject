Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users
  resources :games
  resources :orders
  resources :cart

  get '/dashboard', to: 'dashboard#index', as: 'dashboard'
  get '/charges/new', to: 'charges#new', as: 'new_charge'
  post '/buynow', to: 'charges#buy_now', as: 'buy_now'
  post '/buycart', to: 'charges#buy_cart', as: 'buy_cart'
  
  root 'welcome#index'
end
