Rails.application.routes.draw do
  resources :user_preferences
  resources :preferences
  resources :locations
  resources :users

  get "/users/:id/edit", to: "users#edit"
  post "/users/:id/edit", to: "users#edit"
  #get "about", to: "about#index"

  get "/users/:id/friends", to: "users#friends"

  #root to: "main#index" #custom function that creates get request to route
end
