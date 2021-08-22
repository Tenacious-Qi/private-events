Rails.application.routes.draw do
  get    '/signup', to: 'users#new'
  get    '/login',  to: 'sessions#new'

  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create, :show, :index]
  resources :events, only: [:new, :create, :show, :index]
  resources :invitations, only: [:destroy, :new, :create, :show, :update, :edit]

  root 'events#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
