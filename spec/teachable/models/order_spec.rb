require "spec_helper"

RSpec.describe Teachable::Order do
  it "can be created" do
    expect(Teachable::Order.new).to be_a(Teachable::Order)
  end

  it "fields can be changed after new" do
    order = Teachable::Order.new
    order.id = 1
    order.number = 1
    order.total = 10
    order.total_quantity = 100
    order.email = "example@example.com"
    order.special_instructions = "special instructions"

    expect(order.id).to eq(1)
    expect(order.number).to eq(1)
    expect(order.total).to eq(10)
    expect(order.total_quantity).to eq(100)
    expect(order.email).to eq("example@example.com")
    expect(order.special_instructions).to eq("special instructions")
  end

  it "can be hashed" do
    order = Teachable::Order.new(
      id: 1,
      number: 1,
      total: 10,
      total_quantity: 100,
      email: "example@example.com",
      special_instructions: "special instructions"
    )

    hash = order.to_hash

    expect(hash).to match(
      id: 1,
      number: 1,
      total: 10,
      total_quantity: 100,
      email: "example@example.com",
      special_instructions: "special instructions"
    )
  end
end
