Rails.application.routes.draw do
  root 'static#home'
  resources :users

  get '/signup', to: 'users#new'
end
