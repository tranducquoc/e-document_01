require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations",
    sessions: "sessions"}
  mount Sidekiq::Web => "/sidekiq"

  scope "(:locale)", locale: /en|vn/ do
    root "documents#index"

    resources :users
    resources :categories
    resources :documents do
      resources :comments
    end
    resources :favorites, only: [:create, :destroy]
    resources :downloads, only: :create
    resources :relationships, only: [:create, :destroy]

    namespace :api do
      resources :documents, only: :index
      resources :users
    end

    namespace :admin do
      root "admins#index", as: :root
      resources :categories, :documents, :users, :statistic
    end

    get "/:page", to: "static_pages#show"
  end
end
