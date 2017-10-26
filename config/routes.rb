Rails.application.routes.draw do
  resources :buyers
  resources :foods
  get 'home/hello'
  get 'home/goodbye'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
