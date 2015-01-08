require 'sidekiq/web'
# require 'sidetiq/web'

Rails.application.routes.draw do

  concern :uploadable do
    resources :uploads, only: [:new, :create]
  end

  resources :uploads, only: :destroy

  concern :messageable do
    resources :messages
  end

  concern :reviewable do
    resource :review, only: [:new, :create, :edit, :update, :destroy]
  end

	devise_for :users, controllers: { registrations: 'users/registrations',
                                         sessions: 'sessions' }

	devise_for :contractors, controllers: { registrations: 'contractors/registrations',
                                               sessions: 'sessions' }

  resources :users, only: [:show, :index, :destroy],
                concerns: [:uploadable, :messageable],
                defaults: { uploadable: 'user', messageable: 'user' }

  resources :contractors, only: [:show, :index],
                      concerns: [:uploadable, :messageable],
                      defaults: { uploadable: 'contractor', messageable: 'contractor' } do
  end

  resources :jobs, concerns: [:uploadable, :reviewable],
                   defaults: { uploadable: 'job',
                               reviewable: 'job' } do
    resources :bids, only: [:create, :show, :update, :destroy]
    resource :review
  end

  resources :examples, concerns: [:uploadable],
                       defaults: { uploadable: 'example' }

  resources :bids, only: :destroy

  resource :contact, only: [:new, :create]
  resource :search, only: :show

  match 'bids/:id/accept' => 'bids#accept_bid', as: 'accept_bid', via: :post
  match 'bids/:id/reject' => 'bids#reject_bid', as: 'reject_bid', via: :post
  match 'jobs/:id/resume_search' => 'jobs#resume_search', as: 'resume_search', via: :post
  match 'jobs/:id/cancel_job' => 'jobs#cancel_job', as: 'cancel_job', via: :post
  match 'jobs/:id/mark_as_complete' => 'jobs#mark_as_complete', as: 'mark_as_complete', via: :post


  # match 'messages/:id/reply' => 'messages#reply', as: 'reply', via: :post

	mount Sidekiq::Web => '/sidekiq'
  root to: 'high_voltage/pages#show', id: 'splash'
end
