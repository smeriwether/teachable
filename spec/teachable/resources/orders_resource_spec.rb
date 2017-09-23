require "spec_helper"

RSpec.describe Teachable::OrdersResource do
  let(:fake_email) { "example@example.com" }
  let(:fake_token) { "foobarbaz1234567890" }
  let(:fake_client) { Teachable::Client.new(email: fake_email, token: fake_token) }

  it "can be created" do
    expect(Teachable::OrdersResource.new(nil)).to be_a(Teachable::OrdersResource)
  end

  it "can return all orders if there are no orders" do
    stub = stub_request(
      :get, "http://localhost:3000/api/orders.json"
    ).with(
      query: hash_including("user_email" => fake_email, "user_token" => fake_token),
    ).to_return(body: no_orders_json)

    orders = Teachable::OrdersResource.new(fake_client).all

    expect(stub).to have_been_requested
    expect(orders).to be_a(Array)
    expect(orders.length).to eq(0)
  end

  it "can return all orders if there is a single order" do
    stub = stub_request(
      :get, "http://localhost:3000/api/orders.json"
    ).with(
      query: hash_including("user_email" => fake_email, "user_token" => fake_token),
    ).to_return(body: one_order_json)

    orders = Teachable::OrdersResource.new(fake_client).all

    expect(stub).to have_been_requested
    expect(orders.length).to eq(1)
    order = orders.first
    expect(order.number).to eq(1)
    expect(order.total).to eq(10)
    expect(order.total_quantity).to eq(100)
    expect(order.user_email).to eq(fake_email)
    expect(order.special_instructions).to eq("special_instructions")
  end

  it "can return all orders if there are multiple orders" do
    stub = stub_request(
      :get, "http://localhost:3000/api/orders.json"
    ).with(
      query: hash_including("user_email" => fake_email, "user_token" => fake_token),
    ).to_return(body: two_orders_json)

    orders = Teachable::OrdersResource.new(fake_client).all

    expect(stub).to have_been_requested
    expect(orders.length).to eq(2)
    order = orders.first
    expect(order.number).to eq(1)
    order = orders.second
    expect(order.number).to eq(2)
  end

  def no_orders_json
    { orders: [] }.to_json
  end

  def one_order_json
    {
      orders: [
        Teachable::Order.new(
          number: 1,
          total: 10,
          total_quantity: 100,
          user_email: fake_email,
          special_instructions: "special_instructions"
        ).to_hash,
      ]
    }.to_json
  end

  def two_orders_json
    {
      orders: [
        Teachable::Order.new(
          number: 1,
          total: 10,
          total_quantity: 100,
          user_email: fake_email,
          special_instructions: "special_instructions"
        ).to_hash,
        Teachable::Order.new(
          number: 2,
          total: 10,
          total_quantity: 100,
          user_email: fake_email,
          special_instructions: "special_instructions"
        ).to_hash,
      ]
    }.to_json
  end
end
