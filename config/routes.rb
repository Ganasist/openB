Rails.application.routes.draw do


	devise_for :users, controllers: { 
									 					confirmations: 'users/confirmations',
										 	 # omniauth_callbacks: 'users/omniauth_callbacks',
											  			  passwords: 'users/passwords',
													  registrations: 'users/registrations',
												 			 	 sessions: 'users/sessions',
												 				  unlocks: 'users/unlocks' }

	devise_for :contractors, controllers: { 
														confirmations: 'contractors/confirmations',
											 # omniauth_callbacks: 'contractors/omniauth_callbacks',
																passwords: 'contractors/passwords',
														registrations: 'contractors/registrations',
											 					 sessions: 'contractors/sessions',
											 					  unlocks: 'contractors/unlocks' }

  # devise_for :contractors
  # devise_for :users
  
  resources :users

  resource :contact, only: [:new, :create]

  mount Upmin::Engine => '/admin'
  root :to => 'high_voltage/pages#show', id: 'splash'
end
