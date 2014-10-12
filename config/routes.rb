Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  
  devise_for :users
  resources :users

  resource :contact, only: [:new, :create]

  root :to => 'high_voltage/pages#show', id: 'splash'
end
