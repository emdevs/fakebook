Rails.application.routes.draw do
  devise_for :users,controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :posts
  
  #for now
  resources :clubs
  # namespace :clubs do
  #   resources :posts
  # end


  # resources :clubs do
  #   resources :posts
  # end

  resources :memberships

  # root "/homepage"

  # get "/homepage", to: "posts#index"

  root "posts#index"

  resources :users, only: [:index, :edit, :update] do
    resource :profile, only: [:show, :edit, :update]
  end

  resources :friend_requests, only: [:new, :create, :index, :destroy, :update]

  post "/posts/:id/like", to: "posts#like", as: "like_post"
  delete "/posts/:id/like", to: "posts#unlike", as: "unlike_post"

  post "/posts/:id/comments/:comment_id/like", to: "comments#like", as: "like_comment"
  delete "/posts/:id/comments/:comment_id/like", to: "comments#unlike", as: "unlike_comment"

  resources :comments, only: [:new, :create, :destroy]

  resources :notifications, only: [:index, :show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
