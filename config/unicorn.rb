if Rails.env.development?
  worker_processes 3
else
  worker_processes 3
end
timeout 15
preload_app true

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end
  @sidekiq_pid ||= spawn("bundle exec sidekiq")
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  if defined?(ActiveRecord::Base)
    config = ActiveRecord::Base.configurations[Rails.env]
    config['reaping_frequency'] = ENV['DB_REAP_FREQ'] || 10 # seconds
    config['pool']            =   ENV['DB_POOL'] || 10
    ActiveRecord::Base.establish_connection(config)
  end

  # Sidekiq.configure_server do |config|
  #   config.redis = { url: ENV['REDISTOGO_URL'],
  #                   size: 5,
  #              namespace: "openbid_#{ Rails.env }" }
  #   config.poll_interval = 5
  # end

  # Sidekiq.configure_client do |config|
  #   config.redis = { url: ENV['REDISTOGO_URL'],
  #                   size: 1,
  #              namespace: "openbid_#{ Rails.env }" }
  # end
end