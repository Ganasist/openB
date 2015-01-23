require 'sidekiq/web'

Rails.application.routes.draw do

  concern :uploadable do
    resources :uploads, only: [:new, :create]
  end

  concern :messageable do
    resources :messages
  end

  concern :reviewable do
    resource :review, only: [:new, :create, :edit, :update, :destroy]
  end

  def api_endpoints
    devise_for :users
    devise_for :contractors

    resource :search, only: :show

    resources :contractors, only: [:index, :show] do
      resource :gallery, only: :show
    end

    resources :users, only: [:show], concerns: [:uploadable, :messageable], defaults: { uploadable: 'user', messageable: 'user' }

    resources :jobs, concerns: [:uploadable, :reviewable],
                     defaults: { uploadable: 'job',
                   reviewable: 'job' } do
      resources :bids, only: [:create, :show, :update, :destroy]
      resource :review
    end

    resources :examples, concerns: [:uploadable],
                         defaults: { uploadable: 'example' }

    match 'bids/:id/accept' => 'bids#accept_bid', as: 'accept_bid', via: :post
    match 'bids/:id/reject' => 'bids#reject_bid', as: 'reject_bid', via: :post
    match 'jobs/:id/resume_search' => 'jobs#resume_search', as: 'resume_search', via: :post
    match 'jobs/:id/cancel_job' => 'jobs#cancel_job', as: 'cancel_job', via: :post
    match 'jobs/:id/mark_as_complete' => 'jobs#mark_as_complete', as: 'mark_as_complete', via: :post
  end

  if Rails.env.staging?
    namespace :api, path: '/', constraints: { subdomain: 'api.staging' }, defaults: { format: :json } do
      namespace :v1 do
        api_endpoints
      end
    end
  else
    namespace :api, path: '/', constraints: { subdomain: 'api' }, defaults: { format: :json } do
      namespace :v1 do
        api_endpoints
      end
    end
  end

	devise_for :users, controllers: { registrations: 'users/registrations',
                                         sessions: 'sessions' }

	devise_for :contractors, controllers: { registrations: 'contractors/registrations',
                                               sessions: 'sessions' }

  resources :users, only: [:show],
                concerns: [:uploadable, :messageable],
                defaults: { uploadable: 'user', messageable: 'user' }

  resources :contractors, only: [:show, :index],
                      concerns: [:uploadable, :messageable],
                      defaults: { uploadable: 'contractor', messageable: 'contractor' } do
    resource :gallery, only: :show
  end

  resources :jobs, concerns: [:uploadable, :reviewable],
                   defaults: { uploadable: 'job',
                               reviewable: 'job' } do
    resources :bids, only: [:create, :show, :update, :destroy]
    resource :review
  end

  resources :examples, concerns: [:uploadable],
                       defaults: { uploadable: 'example' }

  resources :uploads, only: :destroy

  resources :bids, only: :destroy

  resources :messages
  resources :conversations

  resource :contact, only: [:new, :create]
  resource :search, only: :show

  match 'bids/:id/accept' => 'bids#accept_bid', as: 'accept_bid', via: :post
  match 'bids/:id/reject' => 'bids#reject_bid', as: 'reject_bid', via: :post
  match 'jobs/:id/resume_search' => 'jobs#resume_search', as: 'resume_search', via: :post
  match 'jobs/:id/cancel_job' => 'jobs#cancel_job', as: 'cancel_job', via: :post
  match 'jobs/:id/mark_as_complete' => 'jobs#mark_as_complete', as: 'mark_as_complete', via: :post

	mount Sidekiq::Web => '/sidekiq'
  match ':status', to: 'errors#show', constraints: {status: /\d{3}/ }, via: :all
  root to: 'high_voltage/pages#show', id: 'splash'
end
