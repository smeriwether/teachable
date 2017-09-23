require "spec_helper"

RSpec.describe Teachable::Client do
  let(:fake_email) { "example@example.com" }
  let(:fake_token) { "foobarbaz1234567890" }

  it "can be created" do
    expect(Teachable::Client.new(email: nil, token: nil)).to be_a(Teachable::Client)
  end

  it "email and token can be changed after new" do
    client = Teachable::Client.new(email: "", token: "")
    client.email = fake_email
    client.token = fake_token

    expect(client.email).to eq fake_email
    expect(client.token).to eq fake_token
  end

  it "http_client can be changed after new" do
    client = Teachable::Client.new(email: "", token: "")
    client.http_client = "fake client"
    expect(client.http_client).to eq("fake client")
  end

  it "can list all orders" do
    stub = stub_request(
      :get, "http://localhost:3000/api/orders.json"
    ).with(
      query: hash_including("user_email" => fake_email, "user_token" => fake_token),
      headers: { "Accept" => "application/json", "Content-Type" => "application/json" }
    ).to_return(body: two_orders_json)
    client = Teachable::Client.new(email: fake_email, token: fake_token)

    orders = client.orders.all

    expect(stub).to have_been_requested
    expect(orders).to be_a(Array)
    expect(orders.length).to eq(2)
    expect(orders).to all(be_a(Teachable::Order))
  end

  def two_orders_json
    {
      orders: [
        Teachable::Order.new(number: 1, total: nil, total_quantity: nil, user_email: nil).to_hash,
        Teachable::Order.new(number: 2, total: nil, total_quantity: nil, user_email: nil).to_hash
      ]
    }.to_json
  end
end
