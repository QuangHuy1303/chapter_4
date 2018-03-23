Rails.application.routes.draw do
  get "foo/bar"

  get "static_pages/home"
  get "users/new"
  get "/help", to: "static_pages#help"
  get "/contact", to: "static_pages#contact"
  get "/about", to: "static_pages#about"
  get "/signup", to: "users#new"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
