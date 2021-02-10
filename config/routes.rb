Rails.application.routes.draw do
  resources :game

  root 'game#new'
  post '/move', to: 'game#move'
end
