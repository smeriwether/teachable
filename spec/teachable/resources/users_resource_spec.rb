require "spec_helper"

RSpec.describe Teachable::UsersResource do
  let(:current_user_id) { 502 }
  let(:fake_email) { "example@example.com" }
  let(:fake_password) { "password" }
  let(:fake_token) { "foobarbaz1234567890" }
  let(:fake_client) { Teachable::Client.new(email: fake_email, token: fake_token) }

  it "can be created" do
    expect(Teachable::UsersResource.new(nil)).to be_a(Teachable::UsersResource)
  end

  it "can return the current user" do
    stub = stub_request(
      :get, "http://localhost:3000/api/users/current_user/edit.json"
    ).with(
      query: hash_including("user_email" => fake_email, "user_token" => fake_token),
    ).to_return(body: current_user_json)

    user = Teachable::UsersResource.new(fake_client).current_user

    expect(stub).to have_been_requested
    expect(user).to be_a(Teachable::User)
    expect(user.id).to eq(current_user_id)
    expect(user.email).to eq(fake_email)
    expect(user.tokens).to eq(fake_token)
  end

  it "can register a user" do
    params = { email: fake_email, password: fake_password, password_confirmation: fake_password }
    stub = stub_request(
      :post, "http://localhost:3000/users.json"
    ).with(
      body: hash_including("user" => params),
      query: hash_including("user_email" => fake_email, "user_token" => fake_token),
    ).to_return(body: current_user_json)

    user = Teachable::UsersResource.new(fake_client).register(params)

    expect(stub).to have_been_requested
    expect(user).to be_a(Teachable::User)
    expect(user.id).not_to be_nil
    expect(user.tokens).not_to be_nil
    expect(user.email).to eq(fake_email)
  end

  def current_user_json
    {
      "id" => current_user_id,
      "name" => nil,
      "nickname" => nil,
      "image" => nil,
      "email" => fake_email,
      "tokens" => fake_token,
      "created_at" => "2017-09-23T17:12:15.581Z",
      "updated_at" => "2017-09-23T18:44:06.070Z"
    }.to_json
  end
end
