module Teachable
  class UnauthenticatedClient
    attr_accessor :http_client

    def initialize
      self.http_client = HttpClient.new
    end

    def users
      UsersResource.new(self)
    end
  end
end
