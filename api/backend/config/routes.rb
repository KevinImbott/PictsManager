Rails.application.routes.draw do
  post "/login", to: "authentication#login"
  post "/signup", to: "authentication#signup"

  put "/profile", to: "users#update"
  get "/profile", to: "users#profile"

  resources :users
  resources :albums
  post "/albums/:id/add_or_delete_user", to: "albums#add_or_delete_user"
  resources :pictures
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
