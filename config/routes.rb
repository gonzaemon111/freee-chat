Rails.application.routes.draw do
  devise_for :users
  root 'rooms#index'
  resources :users, only: [:index, :edit, :update]
  resources :rooms, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
