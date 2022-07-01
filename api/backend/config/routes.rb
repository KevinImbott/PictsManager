# frozen_string_literal: true

Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  # LOGIN / SIGNUP ROUTES
  post '/login', to: 'authentication#login'
  post '/signup', to: 'authentication#signup'

  # PROFILE ROUTES
  put '/profile', to: 'users#update'
  get '/profile', to: 'users#profile'
  delete '/profile', to: 'users#destroy'

  # ALBUMS ROUTES
  resources :albums
  post '/albums/:id/add_or_delete_user', to: 'albums#add_or_delete_user'

  # PICTURES ROUTES
  resources :pictures
  get '/home', to: 'pictures#home'
  post '/pictures/:id/add_or_delete_user', to: 'pictures#add_or_delete_user'
  post '/pictures/:id/add_or_delete_album', to: 'pictures#add_or_delete_album'

  # USERS ROUTES
  resources :users
end
