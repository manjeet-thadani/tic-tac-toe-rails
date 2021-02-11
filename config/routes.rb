Rails.application.routes.draw do
  resources :game
  
  root 'game#index'
  get '/new/:id', to: 'game#new'
  post '/move', to: 'game#move'
  post '/games', to: 'game#start'
end
