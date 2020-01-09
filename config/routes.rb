Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'home/index'
  get "home/about" => "about#index"
  root 'home#index'
  resources :books
  resources :users, only: [:show, :edit, :update, :index]
end