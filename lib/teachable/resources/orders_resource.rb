module Teachable
  class OrdersResource < Teachable::Resource
    def all
      transform_all(client.http_client.get("/api/orders.json"))
    end

    private

    def model_klass
      Order
    end
  end
end
