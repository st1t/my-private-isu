require_relative './app'

use Rack::Logger
use Rack::CommonLogger

ElasticAPM.start(
  app: Isucondition::App, # required
  config_file: 'elastic_apm.yml' # optional, defaults to config/elastic_apm.yml
)

run Isucondition::App

at_exit { ElasticAPM.stop }

