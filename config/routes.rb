Rails.application.routes.draw do
  root 'main#index'

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
  get 'music' => 'music#show'

<<<<<<< HEAD
 get '/auth/spotify/callback', to: 'music#show'
 # get '/auth/spotify/callback', to: 'spotify'
=======
  get '/auth/spotify/callback', to: 'music#show'
  get '/auth/spotify/callback', to: 'spotify'
>>>>>>> baa8e1dfc9bd17f8fa1623ad71fe465f66482b55

  #~~~~~~~~~~~~trivia~~~~~~~~~~~~~
  get 'trivia' => 'trivia#show'

<<<<<<< HEAD


=======
>>>>>>> baa8e1dfc9bd17f8fa1623ad71fe465f66482b55
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
