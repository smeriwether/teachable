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

  def array_response
    [
      Teachable::Order.new(id: 1, number: 1, total: nil, total_quantity: nil, email: nil).to_hash,
      Teachable::Order.new(id: 1, number: 2, total: nil, total_quantity: nil, email: nil).to_hash
    ].to_json
  end
end
