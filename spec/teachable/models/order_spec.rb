require "spec_helper"

RSpec.describe Teachable::Order do
  it "can be created" do
    expect(
      Teachable::Order.new(
        number: nil, total: nil, total_quantity: nil, user_email: nil, special_instructions: nil
      )
    ).to be_a(Teachable::Order)
  end

  it "fields can be changed after new" do
    order = Teachable::Order.new(
      number: nil, total: nil, total_quantity: nil, user_email: nil, special_instructions: nil
    )
    order.number = 1
    order.total = 10
    order.total_quantity = 100
    order.user_email = "example@example.com"
    order.special_instructions = "special instructions"

    expect(order.number).to eq 1
    expect(order.total).to eq 10
    expect(order.total_quantity).to eq 100
    expect(order.user_email).to eq "example@example.com"
    expect(order.special_instructions).to eq "special instructions"
  end

  it "can be hashed" do
    order = Teachable::Order.new(
      number: 1,
      total: 10,
      total_quantity: 100,
      user_email: "example@example.com",
      special_instructions: "special instructions"
    )

    hash = order.to_hash

    expect(hash).to eq(
      number: 1,
      total: 10,
      total_quantity: 100,
      user_email: "example@example.com",
      special_instructions: "special instructions"
    )
  end
end
