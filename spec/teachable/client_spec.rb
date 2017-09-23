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
end
