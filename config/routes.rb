Rails.application.routes.draw do
  resources :game
  
  root 'game#index'
  post '/move', to: 'game#move'
  post '/games', to: 'game#start'
end
