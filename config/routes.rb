require "sidekiq/web"

Rails.application.routes.draw do
  constraints subdomain: /.*e-document/ do
    constraints subdomain: false do
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
        resources :activites
        resources :favorites, only: [:create, :destroy]
        resources :downloads, only: :create
        resources :relationships, only: [:create, :destroy]
        resources :messages, only: [:index]
        resources :chatrooms
        mount ActionCable.server => "/cable"

        namespace :api do
          resources :documents, only: :index
          resources :users
        end

        namespace :admin do
          root "admins#index", as: :root
          resources :categories, :documents, :users, :statistic, :buycoins
        end

        resources :buycoins

        get "/:page", to: "static_pages#show"
      end  
    end
  end
end
