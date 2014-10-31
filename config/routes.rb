require 'sidekiq/web'
# require 'sidetiq/web'

Rails.application.routes.draw do

  get 'examples/new'

  get 'examples/create'

  get 'examples/edit'

  get 'examples/update'

	devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'sessions' }

	devise_for :contractors, controllers: { registrations: 'contractors/registrations', sessions: 'sessions' }							 

  resources :users, only: [:show, :index, :destroy]
  
  resources :contractors, only: [:show, :index, :destroy]
  
  resources :jobs do
    resources :bids, only: [:create, :update]
  end

  resources :bids, only: [:destroy] 

  resource :contact, only: [:new, :create]
  resource :search, only: [:show]
  
	mount Sidekiq::Web => '/sidekiq'
  mount Upmin::Engine => '/admin'
  root to: 'high_voltage/pages#show', id: 'splash'
end