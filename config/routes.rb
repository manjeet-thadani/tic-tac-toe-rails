Rails.application.routes.draw do
  resources :games, only: [:index]
  
  root 'game#index'
  post '/move', to: 'game#move'
  post '/games', to: 'game#start'
end
