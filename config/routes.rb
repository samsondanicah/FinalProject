Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  constraints(ClientDomainConstraint.new) do
    devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }, as: 'client'
    root 'users/home#index', as: 'client_root'
    resource :profiles, controller: 'users/profiles'
    resource :invite, controller: 'users/invites'
    resources :addresses, except: :show, controller: 'users/addresses'
  end

  constraints(AdminDomainConstraint.new) do
    devise_for :users, controllers: {
      sessions: 'admin/sessions'
    }, as: 'admin'
    root 'admin/home#index', as: 'admin_root'
    resources :users, only: :index, controller: 'admin/users'
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
