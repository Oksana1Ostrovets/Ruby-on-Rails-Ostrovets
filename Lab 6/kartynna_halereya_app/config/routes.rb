Rails.application.routes.draw do
  get "home/index"
  root "home#index"
  resources :paintings
  resources :authors
  resources :genres
end
