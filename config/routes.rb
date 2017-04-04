require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations",
    sessions: "sessions", omniauth_callbacks: "omniauth_callbacks"}
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
    resources :series
    resources :reviews
    resources :organizations do
      resources :admin_add_members, only: [:create, :destroy]
      resources :read_guide , only: [:create, :update, :destroy]
      resources :group_members do
        resources :admin_add_members, only: [:create, :destroy]
      end
      resources :documents
      resources :teams, except: [:index] do
        resources :admin_add_members, only: [:create, :destroy]
        resources :group_members, only: [:create, :destroy, :update] do
          resources :admin_add_members, only: [:create, :destroy]
        end
      end
    end
    resources :group_members, only: [:create, :destroy, :update]

    resources :shares
    mount ActionCable.server => "/cable"

    namespace :api do
      resources :documents, :users, :imageslides, :team_members, :team_requests,
        :organization_members, :organizations, :organization_documents, :teams, only: :index
    end

    namespace :admin do
      root "admins#index", as: :root
      resources :categories, :documents, :users, :statistic, :buycoins,
        :imageslides
    end

    resources :buycoins

    get "/:page", to: "static_pages#show"
  end
end
