module Teachable
  class HttpClient
    include HTTParty
    base_uri "localhost:3000"
    headers "Accept" => "application/json", "Content-Type" => "application/json"

    attr_reader :email, :token

    def initialize(email, token)
      @email = email
      @token = token
    end

    def get(url)
      self.class.get(authenticated_url(url))
    end

    private

    def authenticated_url(url)
      "#{url}?user_email=#{email}&user_token=#{token}"
    end
  end
end
