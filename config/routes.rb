Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post '/login', to: 'users#login'
  post '/create', to: 'users#create'
  get '/users', to: 'users#index'

  post '/find_a_friend', to: 'users#find_a_friend'
  post '/end_friendship', to:'users#end_friendship'

  post '/save_score', to: 'users#save_score'
end
