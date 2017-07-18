Rails.application.routes.draw do
  resources :users
  resources :tickets do
    resources :ticket_replies
  end
  resources :user_types
  resources :sessions, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'password_changes', to: 'password_changes#edit', as: 'password_changes'
  post 'password_changes', to: 'password_changes#update'

  get 'dashboard', to: 'dashboard#index', as: 'dashboard'
  get 'reports', to: 'dashboard#reports', as: 'reports'
  get 'welcome', to: 'dashboard#welcome', as: 'welcome'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get 'registrations', to: 'users#registration', as: 'registrations'
  post 'registrations', to: 'users#create'

  get 'show_tickets/:id', to: 'tickets#show_tickets', as: 'show_tickets'

  root 'dashboard#home'
  ## for API

  mount Users::TypesAPI => '/api/user_types'
  mount Users::UsersAPI => '/api/users'
  mount Tickets::TicketsAPI =>'/api/tickets'
end
