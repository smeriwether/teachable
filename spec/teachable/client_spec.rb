require "spec_helper"

RSpec.describe Teachable::Client, :vcr do
  let(:fake_email) { "dev-8@example.com" }
  let(:fake_token) { "qC3v3HvBfKxCQuyqu49g" }

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
    VCR.use_cassette("all_orders") do
      client = Teachable::Client.new(email: fake_email, token: fake_token)

      orders = client.orders.all

      expect(orders).to be_a(Array)
      expect(orders).to all(be_a(Teachable::Order))
    end
  end
end
