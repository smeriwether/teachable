module Teachable
  class OrdersResource < Teachable::Resource
    def all
      transform_all(client.http_client.get("/api/orders.json"))
    end

    def create(order:)
      transform(client.http_client.post("/api/orders.json", "order" => order.to_hash.except(:id)))
    end

    private

    def model_klass
      Order
    end
  end
end
