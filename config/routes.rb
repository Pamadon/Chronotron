Rails.application.routes.draw do
  root 'main#index'
  post '/' => 'main#choice'
  # ~~~~~~~~~Trails~~~~~~~~~~~
  get '/trail' => 'trail#index'
  post '/trail/show' => 'trail#show'
  get '/trail/maps'  => 'trail#maps'

  #~~~~~~~~~~~youtube~~~~~~~~~~~~~
  get 'you_tube_controller/index'
  get 'you_tube_controller/show'
  get 'you_tube_controller/search'
  post 'you_tube_controller/search'
  get 'you_tube_controller/main'

  #~~~~~~~~~~~spotify~~~~~~~~~~~~~
  get '/music' => 'music#show'
  get '/auth/spotify/callback', to: 'music#spotify'
  get '/auth/logout' => 'music#logout'
  get '/auth/failure' => 'music#failure'

  #~~~~~~~~~~~~trivia~~~~~~~~~~~~~
  get 'trivia' => 'trivia#show'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
