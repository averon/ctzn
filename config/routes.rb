Rails.application.routes.draw do
  resources :votes, only: [:index, :show]
  resources :bills, only: [:index]
end
