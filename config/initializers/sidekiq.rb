require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ['john', 'loislane']
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDISTOGO_URL'],
  								size: 5, 
  					 namespace: "openbid_#{ Rails.env }" }
  config.poll_interval = 5
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDISTOGO_URL'],
  								size: 1,
  					 namespace: "openbid_#{ Rails.env }" }
end