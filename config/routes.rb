Rails.application.routes.draw do
  resources :game

  root 'game#new'
  # get '/new', to: 'game#new'
  # get '/computer_move', to: 'game#computer_move'
end
