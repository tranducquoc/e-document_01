Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}
  root "static_pages#home"

  resources :users
  resources :categories
  resources :documents
  resources :relationships, only: [:create, :destroy]

  namespace :api do
    resources :documents, only: :index
  end

  namespace :admin do
    root "home#index"
    resources :categories, :documents, :users
  end

  get "/:page", to: "static_pages#show"
end
