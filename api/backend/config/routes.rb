Rails.application.routes.draw do
  post "/login", to: "authentication#login"
  post "/signup", to: "authentication#signup"

  resources :users, only: [:new, :create]
  resources :albums
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
