Rails.application.routes.draw do
  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end
  root "static_pages#home"
  get "sessions/new"
  get "users/new"
  get "foo/bar"
  get "static_pages/home"
  get "users/new"
  get "/help", to: "static_pages#help"
  get "/contact", to: "static_pages#contact"
  get "/about", to: "static_pages#about"
  get "/signup", to: "users#new"
  get "/index", to: "users#index"
  post "/signup",  to: "users#create"
  get "/login",   to: "sessions#new"
  post "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :users, concerns: :paginatable
end
