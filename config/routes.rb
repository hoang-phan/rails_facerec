Rails.application.routes.draw do
  resource :gcms, only: :create
  resources :images, only: [:index, :create, :update, :destroy]
end
