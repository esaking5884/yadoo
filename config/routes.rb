Rails.application.routes.draw do
  root 'home#top'
  post "reservations/confirm" => "reservations#confirm"
  post "reservations/new" => "reservations#new"
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/top' => 'home#top'
  resources :users
  resources :home
  resources :inns
  resources :reservations
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
