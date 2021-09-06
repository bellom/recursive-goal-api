Rails.application.routes.draw do
  resources :goals, only: %w[index show update]

  get '/goals', to: 'goals#index'
  get '/goal/:id', to: 'goals#show'
  post '/goal/:id', to: 'goals#update'
end
