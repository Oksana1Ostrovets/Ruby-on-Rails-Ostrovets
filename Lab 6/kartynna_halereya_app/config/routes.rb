Rails.application.routes.draw do
  resources :paintings
  resources :authors
  resources :genres do
    delete :destroy_empty_genres, on: :collection
  end  

  get 'catalog', to: 'paintings#catalog', as: 'catalog'

  root "home#index"
end
