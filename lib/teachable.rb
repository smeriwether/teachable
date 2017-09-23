require "teachable/version"
require "active_support/all"
require "httparty"

module Teachable
  autoload :Client, "teachable/client"

  # Models
  autoload :Order, "teachable/models/order"

  # Resources
  autoload :OrdersResource, "teachable/resources/orders_resource"
  autoload :Resource, "teachable/resources/resource"

  # Helpers
  autoload :HttpClient, "teachable/http_client"
end
