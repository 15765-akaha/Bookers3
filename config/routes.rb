Rails.application.routes.draw do
  get 'book_comment/create'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'home/index'
  get "home/about" => "about#index"
  root 'home#index'
  resources :books do
  resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :index]
end
