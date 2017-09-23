module Teachable
  class Resource
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def transform_all(body)
      parsed = parse_json(body)
      parsed&.map { |p| to_model(p) }
    end

    private

    def parse_json(body)
      JSON.parse(body)
    end

    def to_model(object)
      model_klass.new(object.symbolize_keys)
    end
  end
end