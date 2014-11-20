require 'sidekiq'
require 'sidekiq/web'

heroku = nil
if ENV['HEROKU_APP']
  heroku = Autoscaler::HerokuScaler.new
end

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [ENV['SIDEKIQ_WEB_NAME'], ENV['SIDEKIQ_WEB_PASS']]
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