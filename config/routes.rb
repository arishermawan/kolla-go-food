Rails.application.routes.draw do

  get 'admin' => 'admin#index'

  root 'store#index', as: 'store_index'

  resources :line_items
  resources :categories
  resources :orders
  resources :users
  resources :buyers
  resources :foods
  resources :carts
  resources :vouchers
  resources :tags
  resources :restaurants

  get 'store/index'
  get 'home/hello'
  get 'home/goodbye'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
