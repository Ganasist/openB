require 'sidekiq/web'
# require 'sidetiq/web'

Rails.application.routes.draw do
  concern :uploadable do
    resources :uploads, only: [:new, :create, :destroy]
  end

	devise_for :users, controllers: { registrations: 'users/registrations', 
                                          sessions: 'sessions' }

	devise_for :contractors, controllers: { registrations: 'contractors/registrations', 
                                               sessions: 'sessions' }							 

  resources :users, only: [:show, :index, :destroy], concerns: :uploadable, defaults: { uploadable: 'user' }

  resources :contractors, only: [:show, :index], concerns: :uploadable, defaults: { uploadable: 'contractor' } do
    resources :examples, except: :destroy
  end
  
  resources :jobs, concerns: :uploadable, defaults: { uploadable: 'job' } do
    resources :bids, only: [:create, :update, :destroy]
  end
  
  resources :examples, only: :destroy, concerns: :uploadable, defaults: { uploadable: 'example' }
  resources :bids, only: :destroy

  resource :contact, only: [:new, :create]
  resource :search, only: :show
  
	mount Sidekiq::Web => '/sidekiq'
  root to: 'high_voltage/pages#show', id: 'splash'
end