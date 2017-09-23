module Teachable
  class Client
    attr_accessor :email, :token, :http_client

    def initialize(email:, token:)
      self.email = email
      self.token = token
      self.http_client = HttpClient.new(email, token)
    end

    def orders
      OrdersResource.new(self)
    end
  end
end
