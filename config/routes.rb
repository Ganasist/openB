require 'sidekiq/web'
# require 'sidetiq/web'

Rails.application.routes.draw do

  resources :posts

	devise_for :users, controllers: { 
									 					# confirmations: 'users/confirmations',
										 	 # omniauth_callbacks: 'users/omniauth_callbacks',
											  			  # passwords: 'users/passwords',
													  	registrations: 'users/registrations'
												 			 	 # sessions: 'users/sessions',
												 				  # unlocks: 'users/unlocks' 
													 				},
														path: 'users', path_names: { 
																							sign_in: 'login', 
																						 sign_out: 'logout', 
																						  sign_up: 'register' }

	devise_for :contractors, controllers: { 
														# confirmations: 'contractors/confirmations',
											 # omniauth_callbacks: 'contractors/omniauth_callbacks',
																# passwords: 'contractors/passwords',
														registrations: 'contractors/registrations'
											 					 # sessions: 'contractors/sessions',
											 					  # unlocks: 'contractors/unlocks'
											 					  			},
														path: 'contractors', path_names: { 
																										sign_in: 'login', 
																									 sign_out: 'logout', 
																									  sign_up: 'register' }


  resources :users, only: [:show, :index, :destroy]
  resources :contractors, only: [:show, :index, :destroy]

  resource :contact, only: [:new, :create]

  
	mount Sidekiq::Web => '/sidekiq'
  mount Upmin::Engine => '/admin'
  root :to => 'high_voltage/pages#show', id: 'splash'
end
