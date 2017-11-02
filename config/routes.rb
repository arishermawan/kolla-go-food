Rails.application.routes.draw do

  root 'store#index', as: 'store_index'

  resources :line_items
  resources :categories
  resources :orders
  resources :users
  resources :buyers
  resources :foods
  resources :carts

  get 'store/index'
  get 'home/hello'
  get 'home/goodbye'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
