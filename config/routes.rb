require 'sidekiq/web'
# require 'sidetiq/web'

Rails.application.routes.draw do

	# authenticated :user do
 #    root to: 'users#show', as: :authenticated_user_root
 #  end

 #  authenticated :contractor do
 #    root to: 'contractors#show', as: :authenticated_contractor_root
 #  end

	devise_for :users, controllers: { registrations: 'users/registrations' }

	devise_for :contractors, controllers: { registrations: 'contractors/registrations' }							 

  resources :users, only: [:show, :index, :destroy]
  resources :contractors, only: [:show, :index, :destroy]
  resources :jobs
  resources :posts
  resource :contact, only: [:new, :create]
  
	mount Sidekiq::Web => '/sidekiq'
  mount Upmin::Engine => '/admin'
  root to: 'high_voltage/pages#show', id: 'splash'
end
