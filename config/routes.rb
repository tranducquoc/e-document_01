require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations",
    sessions: "sessions"}
  root "documents#index"

  resources :users
  resources :categories
  resources :documents do
    resources :comments
  end
  resources :favorites, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  mount Sidekiq::Web => "/sidekiq"

  namespace :api do
    resources :documents, only: :index
    resources :users
  end

  namespace :admin do
    root "admins#index", as: :root
    resources :categories, :documents, :users
  end

  get "/:page", to: "static_pages#show"
end
