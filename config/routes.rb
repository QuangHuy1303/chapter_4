Rails.application.routes.draw do
  get "foo/bar"

  get "static_pages/home"

  get "cd static_pages/help"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#hello'
end
