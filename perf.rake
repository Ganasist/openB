  require 'bundler'
  Bundler.setup

  require 'derailed_benchmarks'
  require 'derailed_benchmarks/tasks'

task :rack_load do
  require 'config.ru'
  USE_SERVER=unicorn
  TEST_COUNT=10
  # DERAILED_APP =
end