Rails.application.routes.draw do
  post "/login", to: "authentication#login"
  post "/signup", to: "authentication#signup"

  put "/profile", to: "users#update"
  get "/profile", to: "users#profile"

  resources :users
  resources :albums
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
