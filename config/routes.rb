Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'home/index'
  get "home/about" => "about#index"
  root 'home#index'
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :index] do
    resource :relationships, only: [:create, :destroy]
    member do
      get :follows, :followers
    end
  end

end
