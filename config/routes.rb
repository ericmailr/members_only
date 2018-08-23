Rails.application.routes.draw do

  get '/signin', to: 'sessions#new'

  post '/signin', to: 'sessions#create'

  resources :users
end
