require "spec_helper"

RSpec.describe Teachable::UnauthenticatedClient, :vcr do
  let(:fake_email) { "dev-8@example.com" }
  let(:fake_password) { "password" }

  it "can be created" do
    expect(Teachable::UnauthenticatedClient.new).to be_a(Teachable::UnauthenticatedClient)
  end

  it "http_client can be changed after new" do
    client = Teachable::UnauthenticatedClient.new
    client.http_client = "fake client"
    expect(client.http_client).to eq("fake client")
  end

  it "can register a user" do
    random_email = "dev+#{SecureRandom.hex}@example.com"
    VCR.use_cassette("unauthenticated_register_user") do
      client = Teachable::UnauthenticatedClient.new
      user = client.users.register(
        email: random_email, password: fake_password, password_confirmation: fake_password
      )
      expect(user).to be_a(Teachable::User)
      expect(user.id).not_to be_nil
    end
  end

  it "can authenticate a user" do
    VCR.use_cassette("unauthenticated_authenticate_user") do
      client = Teachable::UnauthenticatedClient.new
      user = client.users.authenticate(email: fake_email, password: fake_password)
      expect(user).to be_a(Teachable::User)
      expect(user.id).not_to be_nil
    end
  end
end
