require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [ENV['SIDEKIQ_WEB_NAME'], ENV['SIDEKIQ_WEB_PASS']]
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDISTOGO_URL'],
  								size: 8,
  					 namespace: "openbid_#{ Rails.env }" }
  config.poll_interval = 5

  database_url = ENV['DATABASE_URL']
  if database_url
    ENV['DATABASE_URL'] = "#{ database_url }?pool=#{ ENV['DB_POOL'] }"
    ActiveRecord::Base.establish_connection
  end

  config.on(:startup) do
    puts 'Worker starting up!'
  end
  config.on(:quiet) do
    puts 'Worker is quiet!'
  end
  config.on(:shutdown) do
    puts 'Worker shutting down!'
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDISTOGO_URL'],
  								size: 1,
  					 namespace: "openbid_#{ Rails.env }" }
end
