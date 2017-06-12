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




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
