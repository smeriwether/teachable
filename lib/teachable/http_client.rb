module Teachable
  UnsucessfulRequestError = Class.new(::StandardError)

  class HttpClient
    include HTTParty

    headers "Accept" => "application/json", "Content-Type" => "application/json"
    default_timeout 10

    attr_reader :email, :token

    def initialize(email = nil, token = nil)
      self.class.default_options[:base_uri] = ENV["URI"] || "localhost:3000"
      @email = email
      @token = token
    end

    def get(url)
      check_error { self.class.get(authenticated_url(url)) }
    end

    def post(url, body)
      check_error { self.class.post(authenticated_url(url), body: body.to_json) }
    end

    def destroy(url)
      check_error { self.class.delete(authenticated_url(url)) }
    end

    private

    def check_error
      resp = yield
      if resp && resp.success?
        resp.body
      else
        raise UnsucessfulRequestError.new(resp.body)
      end
    end

    def authenticated_url(url)
      return url unless email && token
      "#{url}?user_email=#{CGI.escape(email)}&user_token=#{CGI.escape(token)}"
    end
  end
end
