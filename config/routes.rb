Rails.application.routes.draw do
  root 'events#index'
  
  get    '/signup', to: 'users#new'
  get    '/login',  to: 'sessions#new'

  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :events
  resources :invitations, only: [:destroy, :new, :create, :update]
  get '/invitations', to: redirect('/events')

  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
