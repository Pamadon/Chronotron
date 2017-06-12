Rails.application.routes.draw do
  get 'you_tube_controller/index'

  get 'you_tube_controller/show'

  get 'you_tube_controller/search'

	get 'you_tube_controller/main'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
