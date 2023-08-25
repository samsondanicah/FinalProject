Rails.application.routes.draw do

  constraints(ClientDomainConstraint.new) do
    devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }, as: 'client'
    root 'users/home#index', as: 'client_root'
    scope module: :users do
      resource :profiles
      resource :invite
      resources :lottery, only: [:index, :show, :create]
      resources :addresses, except: :show
    end
  end

  constraints(AdminDomainConstraint.new) do
    devise_for :users, controllers: {
      sessions: 'admin/sessions'
    }, as: 'admin'
    root 'admin/home#index', as: 'admin_root'
    scope module: :admin do
      resources :users, only: :index
      resources :categories
      resources :items do
        patch :start
        patch :pause
        patch :end
        patch :cancel
      end
      resources :bets, only: [:index] do
        patch :won
        patch :lost
        patch :cancel
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :regions, only: %i[index show], defaults: { format: :json } do
        resources :provinces, only: :index, defaults: { format: :json }
      end
      resources :provinces, only: %i[index show], defaults: { format: :json } do
        resources :cities, only: :index, defaults: { format: :json }
      end

      resources :cities, only: %i[index show], defaults: { format: :json } do
        resources :barangays, only: :index, defaults: { format: :json }
      end

      resources :barangays, only: %i[index show], defaults: { format: :json }
    end
  end
end



