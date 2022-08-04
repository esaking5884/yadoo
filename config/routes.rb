Rails.application.routes.draw do
  root "home#top"
  post "reservations/confirm" => "reservations#confirm"
  patch "reservations/edit_confirm" => "reservations#edit_confirm"
  post "reservations/new" => "reservations#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  get "/top" => "home#top"
  get "search" => "inns#search"
  get "/inns/:id/new_image" => "inns#new_image"
  post "inns/create_image" => "inns#create_image"
  delete "inns/:id/destroy_image" => "inns#destroy_image"
  resources :users
  resources :home
  resources :inns
  resources :reservations
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
