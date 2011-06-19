Myapp::Application.routes.draw do
  resources :posts

  resources :home
  match ':controller/:action/:id'
  match ':controller/:action/:id.:format'

  get "home/index"
  root :to => "home#index"
end
