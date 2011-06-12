Myapp::Application.routes.draw do
  resources :posts
  match ':controller/:action/:id'
  match ':controller/:action/:id.:format'
  root :to => 'posts#index'
end
