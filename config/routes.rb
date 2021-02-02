Rails.application.routes.draw do
  devise_for :users

  resources :posts
  # root "/homepage"

  # get "/homepage", to: "posts#index"

  root "posts#index"

  resources :users, only: [:index] do
    resource :profile
  end

  # resources :users, only: [:show, :index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
