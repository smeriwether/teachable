module Teachable
  class Resource
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def transform_all(resp)
      parsed = parse_json(resp)
      parsed.dig("orders")&.map { |p| to_model(p) }
    end

    private

    def parse_json(resp)
      JSON.parse(resp)
    end

    def to_model(object)
      model_klass.new(object.symbolize_keys)
    end
  end
end
