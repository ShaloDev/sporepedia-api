Rails.application.routes.draw do
  devise_for :users
  root to: "creatures#index"
  resources :creatures, only: [:show, :index, :create, :destroy]
  resources :collection, only: [:index]
  get 'download_creature/:id', to: 'creatures#download', as: 'download_creature'  
end
