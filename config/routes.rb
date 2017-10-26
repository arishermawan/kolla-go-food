Rails.application.routes.draw do
  root 'store#index', as: 'store_index'
  resources :foods
  get 'store/index'
  resources :buyers
  get 'home/hello'
  get 'home/goodbye'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
