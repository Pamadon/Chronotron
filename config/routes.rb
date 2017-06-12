Rails.application.routes.draw do
  root 'main#index'

  # ~~~~~~~~~Trails~~~~~~~~~~~
  get '/trail' => 'trail#index'
  post '/trail/show' => 'trail#show'
  post 'directions' => 'trail#directions'
  get :maps, :controller => :trail

  #~~~~~~~~~~~youtube~~~~~~~~~~~~~
  get 'you_tube_controller/index'
  get 'you_tube_controller/show'
  get 'you_tube_controller/search'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
