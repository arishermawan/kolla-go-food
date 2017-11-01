Rails.application.routes.draw do
  resources :carts
  root 'store#index', as: 'store_index'
  resources :foods
  get 'store/index'
  resources :buyers
  get 'home/hello'
  get 'home/goodbye'
  resources :line_items
  resources :categories
  resources :orders

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
