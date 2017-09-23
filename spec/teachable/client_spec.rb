require "spec_helper"

RSpec.describe Teachable::Client, :vcr do
  let(:real_email) { "dev-8@example.com" }
  let(:real_password) { "password" }
  let(:real_token) { "qC3v3HvBfKxCQuyqu49g" }

  it "can be created" do
    expect(Teachable::Client.new(email: nil, token: nil)).to be_a(Teachable::Client)
  end

  it "email and token can be changed after new" do
    client = Teachable::Client.new(email: "", token: "")
    client.email = real_email
    client.token = real_token

    expect(client.email).to eq(real_email)
    expect(client.token).to eq(real_token)
  end

  it "http_client can be changed after new" do
    client = Teachable::Client.new(email: "", token: "")
    client.http_client = "real client"
    expect(client.http_client).to eq("real client")
  end

  it "can list all orders" do
    VCR.use_cassette("all_orders") do
      client = Teachable::Client.new(email: real_email, token: real_token)

      orders = client.orders.all

      expect(orders).to be_a(Array)
      expect(orders).to all(be_a(Teachable::Order))
      orders.each do |order|
        expect(order.id).not_to be_nil
      end
    end
  end

  it "can create an order" do
    VCR.use_cassette("create_order") do
      client = Teachable::Client.new(email: real_email, token: real_token)

      order = Teachable::Order.new(total: 10, total_quantity: 100, email: real_email)
      order = client.orders.create(order: order)

      expect(order).to be_a(Teachable::Order)
      expect(order.id).not_to be_nil
      expect(order.number).not_to be_nil
      expect(order.total).to eq("10.0")
      expect(order.total_quantity).to eq(100)
      expect(order.email).to eq(real_email)
    end
  end

  it "can delete an order" do
    client = Teachable::Client.new(email: real_email, token: real_token)
    order_id = nil

    VCR.use_cassette("all_orders") do
      orders = client.orders.all
      order_id = orders.last.id
    end

    VCR.use_cassette("delete_order") do
      client = Teachable::Client.new(email: real_email, token: real_token)
      client.orders.destroy(order_id: order_id)
    end
  end

  it "can get the current user" do
    VCR.use_cassette("current_user") do
      client = Teachable::Client.new(email: real_email, token: real_token)

      user = client.users.current_user

      expect(user).to be_a(Teachable::User)
      expect(user.id).not_to be_nil
    end
  end

  it "can register a user" do
    random_email = "dev+#{SecureRandom.hex}@example.com"
    VCR.use_cassette("register_user") do
      client = Teachable::Client.new(email: real_email, token: real_token)
      user = client.users.register(
        email: random_email, password: real_password, password_confirmation: real_password
      )
      expect(user).to be_a(Teachable::User)
      expect(user.id).not_to be_nil
    end
  end

  it "can authenticate a user" do
    VCR.use_cassette("authenticate_user") do
      client = Teachable::Client.new(email: real_email, token: real_token)
      user = client.users.authenticate(email: real_email, password: real_password)
      expect(user).to be_a(Teachable::User)
      expect(user.id).not_to be_nil
    end
  end

  it "will raise an error when trying to register an existing user" do
    VCR.use_cassette("register_user_error") do
      client = Teachable::Client.new(email: real_email, token: real_token)
      expect do
        client.users.register(
          email: real_email, password: real_password, password_confirmation: real_password
        )
      end.to raise_error(Teachable::UnsucessfulRequestError)
    end
  end

  it "will raise en error when trying to create an order with missing data" do
    VCR.use_cassette("create_order_error") do
      client = Teachable::Client.new(email: real_email, token: real_token)
      expect do
        order = Teachable::Order.new(total: 10)
        client.orders.create(order: order)
      end.to raise_error(Teachable::UnsucessfulRequestError)
    end
  end
end
