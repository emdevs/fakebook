Rails.application.routes.draw do
  devise_for :users

  resources :posts
  # root "/homepage"

  # get "/homepage", to: "posts#index"

  root "posts#index"

  resources :users, only: [:index, :edit, :update] do
    resource :profile, only: [:show]
  end

  resources :friend_requests, only: [:new, :create, :index, :destroy, :update]

  post "/posts/:id/like", to: "posts#like", as: "like"

  resources :comments, only: [:new, :create, :destroy]

  resources :notifications, only: [:index, :show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
