Rails.application.routes.draw do
  resources :goals, only: %w[index show update]

  get '/goals', to: 'goals#index'
  get '/goals/:id', to: 'goals#show'
  post '/goals/:id', to: 'goals#update'
end
