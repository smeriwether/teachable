module Teachable
  class HttpClient
    include HTTParty
    headers "Accept" => "application/json", "Content-Type" => "application/json"

    attr_reader :email, :token

    def initialize(email, token)
      self.class.default_options[:base_uri] = ENV["URI"] || "localhost:3000"
      @email = email
      @token = token
    end

    def get(url)
      self.class.get(authenticated_url(url))&.body
    end

    private

    def authenticated_url(url)
      "#{url}?user_email=#{email}&user_token=#{token}"
    end
  end
end
