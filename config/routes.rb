Rails.application.routes.draw do
  devise_for :users,controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: "walls/posts#index"

  resources :clubs do
    resources :posts, module: :clubs do
      resources :comments, only: [:new, :create, :destroy]
    end
  end

  resource :wall do 
    resources :posts, module: :walls do
      resources :comments, only: [:new, :create, :destroy]
    end
  end

  resources :memberships, only: [:create, :update, :destroy]

  resources :users, only: [:index, :edit, :update] do
    resource :profile, only: [:show, :edit, :update]
  end

  resources :friend_requests, only: [:new, :create, :index, :destroy, :update]

  #Like and unlike paths
  post "/posts/:id/like", to: "posts#like", as: "like_post" 
  delete "/posts/:id/like", to: "posts#unlike", as: "unlike_post"

  post "/posts/:post_id/comments/:id/like", to: "comments#like", as: "like_comment"
  delete "/posts/:post_id/comments/:id/like", to: "comments#unlike", as: "unlike_comment"

  resources :notifications, only: [:index, :show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
