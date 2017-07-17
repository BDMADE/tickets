Rails.application.routes.draw do
  get 'products/index'

  get 'products/show'

  get 'products/new'

  get 'products/create'

  get 'products/edit'

  get 'products/update'

  get 'products/destroy'

  resources :users
  resources :tickets do
    resources :ticket_replies
  end
  resources :user_types
  resources :sessions, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'password_changes', to: 'password_changes#edit', as: 'password_changes'
  post 'password_changes', to: 'password_changes#update'

  get 'dashboard', to: 'dashboard#index'
  get 'welcome', to: 'dashboard#welcome'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get 'registrations', to: 'users#registration', as: 'registrations'
  post 'registrations', to: 'users#create'

  get 'show_tickets/:id', to: 'tickets#show_tickets'

  root 'dashboard#home'
  ## for API

  mount Users::TypesAPI => '/api/user_types'

end
