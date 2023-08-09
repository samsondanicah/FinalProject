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
  end

  constraints(AdminDomainConstraint.new) do
    devise_for :users, controllers: {
      sessions: 'admin/sessions'
    }, as: 'admin'
    root 'admin/home#index', as: 'admin_root'
  end
end
