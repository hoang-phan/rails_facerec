Rails.application.routes.draw do
  resource :train, only: :create
end
