Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'

  constraints(ClientDomainConstraint.new) do
    resources :posts do
      resources :comments, except: :show
    end
  end

  constraints(AdminDomainConstraint.new) do
    namespace :admin do
      resources :users
    end
  end

end
