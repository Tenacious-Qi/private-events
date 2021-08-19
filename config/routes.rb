Rails.application.routes.draw do
  get    '/signup', to: 'users#new'
  get    '/login',  to: 'sessions#new'
  # necessary to prevent error on page refresh after a failed signup
  get    '/users',  to: 'users#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, only: [:new, :create, :show]
  resources :events, only: [:new, :create, :show, :index]
  resources :invitations, only: [:destroy, :new, :create, :show, :update, :edit]

  root 'events#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
