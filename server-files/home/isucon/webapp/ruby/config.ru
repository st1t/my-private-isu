require 'ddtrace/auto_instrument'
require_relative './app'

Datadog.configure do |c|
  c.service = 'isucon12'
end

use Datadog::Tracing::Contrib::Rack::TraceMiddleware
use Rack::Logger
use Rack::CommonLogger

run Isucondition::App

