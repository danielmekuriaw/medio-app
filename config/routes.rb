Rails.application.routes.draw do
  resources :user_preferences
  resources :preferences
  resources :locations
  resources :users

  get "/users/:id/edit", to: "users#edit"
  post "/users/:id/edit", to: "users#edit"
  post "/users/:id", to: "users#delete"
  #get "about", to: "about#index"

  get "/users/:id/followers", to: "users#followers"
  get "/users/:id/following", to: "users#following"

  get "/users/:id/follow", to: "users#follow"
  post "/users/:id/follow", to: "users#follow"


  #root to: "main#index" #custom function that creates get request to route
end
