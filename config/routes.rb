Rails.application.routes.draw do

  get 'dashboard/index'
  get 'dashboard' => 'dashboard#index'

  get 'admin' => 'admin#index'


  post 'admin' => 'admin#index'
  get 'orders/search' => 'orders#search'
  post 'orders/search' => 'orders#search'

  root 'store#index', as: 'store_index'

  resources :line_items
  resources :categories
  resources :orders
  resources :users
  resources :buyers
  resources :carts
  resources :vouchers
  resources :tags
  resources :reviews

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :foods
    end
  end

  resources :foods do
    resources :reviews
  end

  resources :restaurants do
    resources :reviews
  end

  get 'store/index'
  get 'home/hello'
  get 'home/goodbye'

  get '/users/:id/topup', to: 'users#topup', as: 'user_topup'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
