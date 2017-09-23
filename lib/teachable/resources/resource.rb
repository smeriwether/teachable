module Teachable
  NullResponseBodyError = Class.new(::StandardError)

  class Resource
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def transform_all(body)
      parsed = parse_json(body)
      parsed&.map { |p| to_model(p) }
    end

    def transform(body)
      to_model(parse_json(body))
    end

    private

    def parse_json(body)
      resp = JSON.parse(body)
      raise NullResponseBodyError.new(body) unless resp
      resp
    end

    def to_model(object)
      model_klass.new(object.symbolize_keys)
    end
  end
end
