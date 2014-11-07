require 'sidekiq/web'
# require 'sidetiq/web'

Rails.application.routes.draw do
  concern :uploadable do
    resources :uploads, only: [:new, :create, :destroy]
  end

	devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'sessions' }

	devise_for :contractors, controllers: { registrations: 'contractors/registrations', sessions: 'sessions' }							 

  resources :users, only: [:show, :index, :destroy], concerns: :uploadable

  resources :contractors, only: [:show, :index], concerns: :uploadable do
    resources :examples, except: :destroy, concerns: :uploadable
  end
  
  resources :jobs, concerns: :uploadable do
    resources :bids, only: [:create, :update, :destroy]
  end
  
  resources :examples, only: :destroy
  resources :bids, only: :destroy

  resource :contact, only: [:new, :create]
  resource :search, only: :show
  
	mount Sidekiq::Web => '/sidekiq'
  mount Upmin::Engine => '/admin'
  root to: 'high_voltage/pages#show', id: 'splash'
end