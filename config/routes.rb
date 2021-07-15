Rails.application.routes.draw do
  resources :user_preferences
  resources :preferences
  resources :locations
  resources :users

  get "/", to: "sessions#homepage"

  get "developers", to: "developers#index"

 #this get and post request sends user to data
  post "sign_up", to: "users#create"

  #root to: "main#index" #custom function that creates get request to route
end
