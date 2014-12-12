require 'sidekiq/web'
# require 'sidetiq/web'

Rails.application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  concern :uploadable do
    resources :uploads, only: [:new, :create, :destroy]
  end

  concern :commentable do
    resources :comments, only: [:new, :create, :edit, :update, :destroy]
  end

  concern :commenterable do
    resources :comments, only: [:new, :create, :edit, :update, :destroy]
  end

	devise_for :users, controllers: { registrations: 'users/registrations',
                                          sessions: 'sessions' }

	devise_for :contractors, controllers: { registrations: 'contractors/registrations',
                                               sessions: 'sessions' }

  resources :users, only: [:show, :index, :destroy],
                concerns: [:uploadable, :commentable, :commenterable],
                defaults: { uploadable: 'user',
                           commentable: 'user' }

  resources :contractors, only: [:show, :index],
                      concerns: [:uploadable, :commentable, :commenterable],
                      defaults: { uploadable: 'contractor',
                                 commentable: 'contractor' } do
  end

  resources :jobs, concerns: [:uploadable, :commentable],
                   defaults: { uploadable: 'job', commentable: 'job' } do
    resources :bids, only: [:create, :update, :destroy]
    resources :reviews
  end

  resources :examples, concerns: [:uploadable, :commentable],
                       defaults: { uploadable: 'example', commentable: 'example' }

  resources :bids, only: :destroy

  resource :contact, only: [:new, :create]
  resource :search, only: :show

  match 'bids/:id/accept' => 'bids#accept_bid', as: 'accept_bid', via: :post
  match 'bids/:id/reject' => 'bids#reject_bid', as: 'reject_bid', via: :post

	mount Sidekiq::Web => '/sidekiq'
  root to: 'high_voltage/pages#show', id: 'splash'
end
