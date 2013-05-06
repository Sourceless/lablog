Lablog::Application.routes.draw do
  resources :posts

  root :to => "posts#show"
  match '/:id' => "posts#show"
end
