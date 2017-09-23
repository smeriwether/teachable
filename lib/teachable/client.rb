module Teachable
  class Client
    attr_accessor :email, :token

    def initialize(email:, token:)
      self.email = email
      self.token = token
    end
  end
end
