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
    expect(order.id).to eq(838)
    expect(order.number).to eq("5b763124393ab6a6")
    expect(order.total).to eq("10.0")
    expect(order.total_quantity).to eq(100)
    expect(order.email).to eq("stephen@example.com")
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
    expect(orders.first.id).not_to be_nil
    expect(orders.second.id).not_to be_nil
  end

  it "can create an order" do
    params = { number: 1, total: 10, total_quantity: 100, email: fake_email, special_instructions: nil }
    stub = stub_request(
      :post, "http://localhost:3000/api/orders.json"
    ).with(
      query: hash_including("user_email" => fake_email, "user_token" => fake_token),
      body: hash_including("order" => params),
    ).to_return(body: new_order_json(params))

    order = Teachable::Order.new(params)
    order = Teachable::OrdersResource.new(fake_client).create(order: order)

    expect(stub).to have_been_requested
    expect(order).to be_a(Teachable::Order)
    expect(order.id).not_to be(nil)
    expect(order.number).to eq(params[:number])
    expect(order.total).to eq(params[:total])
    expect(order.total_quantity).to eq(params[:total_quantity])
    expect(order.email).to eq(params[:email])
  end

  def no_orders_json
    [].to_json
  end

  def one_order_json
    [
      {
        "id" => 838,
        "number" => "5b763124393ab6a6",
        "total" => "10.0",
        "total_quantity" => 100,
        "email" => "stephen@example.com",
        "special_instructions" => nil,
        "created_at" => "2017-09-23T17:57:01.644Z",
        "updated_at" => "2017-09-23T17:57:01.644Z"
      }
    ].to_json
  end

  def two_orders_json
    [
      {
        "id" => 838,
        "number" => "5b763124393ab6a6",
        "total" => "10.0",
        "total_quantity" => 100,
        "email" => "stephen@example.com",
        "special_instructions" => nil,
        "created_at" => "2017-09-23T17:57:01.644Z",
        "updated_at" => "2017-09-23T17:57:01.644Z"
      },
      {
        "id" => 839,
        "number" => "9eac226887dbc95c",
        "total": "10.0",
        "total_quantity" => 100,
        "email" => "stephen@example.com",
        "special_instructions" => nil,
        "created_at" => "2017-09-23T17:57:07.510Z",
        "updated_at" => "2017-09-23T17:57:07.510Z"
      }
    ].to_json
  end

  def new_order_json(params)
    params.merge(id: 1, special_instructions: nil, created_at: Time.now, updated_at: Time.now).to_json
  end
end
