require 'sidekiq/web'
# require 'sidetiq/web'

Rails.application.routes.draw do

	devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'sessions' }

	devise_for :contractors, controllers: { registrations: 'contractors/registrations', sessions: 'sessions' }							 

  resources :users, only: [:show, :index, :destroy]
  resources :contractors, only: [:show, :index, :destroy]
  resources :jobs
  resource :contact, only: [:new, :create]
  
	mount Sidekiq::Web => '/sidekiq'
  mount Upmin::Engine => '/admin'
  root to: 'high_voltage/pages#show', id: 'splash'
end