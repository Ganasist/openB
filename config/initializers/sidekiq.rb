require 'sidekiq'
require 'sidekiq/web'
require 'autoscaler/sidekiq'
require 'autoscaler/heroku_scaler'

heroku = nil
if ENV['HEROKU_APP']
  heroku = Autoscaler::HerokuScaler.new
end

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [ENV['SIDEKIQ_WEB_NAME'], ENV['SIDEKIQ_WEB_PASS']]
end

Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    if heroku
      p "[Sidekiq] Running on Heroku, autoscaler is used"
	    chain.add(Autoscaler::Sidekiq::Server, Autoscaler::HerokuScaler.new, 60) # 60 second timeout
    else
      p "[Sidekiq] Running locally, so autoscaler isn't used"
    end
  end
  config.redis = { url: ENV['REDISTOGO_URL'],
  								size: 5, 
  					 namespace: "openbid_#{ Rails.env }" }
  config.poll_interval = 5
end

Sidekiq.configure_client do |config|
	if heroku
    config.client_middleware do |chain|
	    chain.add Autoscaler::Sidekiq::Client, 'default' => Autoscaler::HerokuScaler.new
    end
  end
  config.redis = { url: ENV['REDISTOGO_URL'],
  								size: 1,
  					 namespace: "openbid_#{ Rails.env }" }
end