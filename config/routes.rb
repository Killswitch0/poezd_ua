Rails.application.routes.draw do
  resources :railway_stations
  resources :trains
  resources :routes

  get 'welcome/index'
  get "/trains", to: "trains#index"
  get "/trains/:id", to: "trains#show"

  root 'welcome#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
