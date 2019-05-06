Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users
  resources :games
  resources :charges
  resources :orders
  resources :cart

  get '/dashboard', to: 'dashboard#index', as: 'dashboard'

  root 'welcome#index'
end
