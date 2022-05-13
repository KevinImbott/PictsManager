Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  root :to => redirect('/api-docs')

  post "/login", to: "authentication#login"
  post "/signup", to: "authentication#signup"

  put "/profile", to: "users#update"
  get "/profile", to: "users#profile"

  resources :users
  resources :albums
  resources :pictures
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
