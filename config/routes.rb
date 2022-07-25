Rails.application.routes.draw do
  get 'inns/index'
  root 'home#top'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/top' => 'home#top'
  resources :users
  resources :home
  resources :inns
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
