Rails.application.routes.draw do
  resource :recognize, only: :create
  resources :images, only: [:index, :create]
end
