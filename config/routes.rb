Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}
  root "static_pages#home"
  get "/:page/*page", to: "static_pages#show"

  resources :users
end
