Rails.application.routes.draw do
  resources :paintings
  root "paintings#index"
  resources :authors
  resources :genres
end
