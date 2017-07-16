Rails.application.routes.draw do
  get 'password_changes/edit'

  get 'password_changes/update'

  get 'dashboard/index'

  get 'dashboard/blank_dashboard'

  resources :users
  resources :user_types
  resources :sessions, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'password_changes', to: 'password_changes#edit', as: 'password_changes'
  post 'password_changes', to: 'password_changes#update'
  root 'dashboard#index'
  get 'dashboard', to: 'dashboard#index'
  get 'welcome', to: 'dashboard#welcome'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
