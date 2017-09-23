require "spec_helper"

RSpec.describe Teachable::Resource do
  it "can be created" do
    expect(Teachable::Resource.new(nil)).to be_a(Teachable::Resource)
  end

  it "can transform a HTTParty array response to an array of Teachable::Model" do
    resource = Teachable::OrdersResource.new(nil)

    orders = resource.transform_all(array_response)

    expect(orders).to be_a(Array)
    expect(orders).to all(be_a(Teachable::Order))
  end

  it "can trasnform a HTTParty single instance response to a Teachable::Model instance" do
    resource = Teachable::OrdersResource.new(nil)
    order = resource.transform(single_response)
    expect(order).to be_a(Teachable::Order)
  end

  def array_response
    [
      Teachable::Order.new(id: 1, number: 1, total: nil, total_quantity: nil, email: nil).to_hash,
      Teachable::Order.new(id: 1, number: 2, total: nil, total_quantity: nil, email: nil).to_hash
    ].to_json
  end

  def single_response
    {
      "id" => 841,
      "number" => "015f52f13c5267e8",
      "total" => "10.0",
      "total_quantity" => 100,
      "email" => "stephen@example.com",
      "special_instructions" => nil,
      "created_at" => "2017-09-23T17:57:25.954Z",
      "updated_at" => "2017-09-23T17:57:25.954Z"
    }.to_json
  end
end
