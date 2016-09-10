Rails.application.routes.draw do
  root 'legislators#location'

  resources :votes,       only: [:index, :show]
  resources :bills,       only: [:index, :show]
  resources :legislators, only: [:index, :show]
end
