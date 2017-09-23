require "spec_helper"

RSpec.describe Teachable::HttpClient do
  let(:fake_email) { "example@example.com" }
  let(:fake_token) { "foobarbaz1234567890" }

  it "can be created" do
    expect(Teachable::HttpClient.new(nil, nil)).to be_a(Teachable::HttpClient)
  end

  it "can GET data" do
    stub = stub_request(
      :get, "http://localhost:3000/foo.json"
    ).with(
      query: hash_including("user_email" => fake_email, "user_token" => fake_token),
      headers: { "Accept" => "application/json", "Content-Type" => "application/json" }
    )
    Teachable::HttpClient.new(fake_email, fake_token).get("/foo.json")
    expect(stub).to have_been_requested
  end

  it "can POST data" do
    body = { "foo" => "baz", "bar" => "baz" }
    stub = stub_request(
      :post, "http://localhost:3000/foo.json"
    ).with(
      query: hash_including("user_email" => fake_email, "user_token" => fake_token),
      body: hash_including(body),
      headers: { "Accept" => "application/json", "Content-Type" => "application/json" }
    )
    Teachable::HttpClient.new(fake_email, fake_token).post("/foo.json", body)
    expect(stub).to have_been_requested
  end

  it "can DESTROY data" do
    stub = stub_request(
      :delete, "http://localhost:3000/foo/1.json"
    ).with(
      query: hash_including("user_email" => fake_email, "user_token" => fake_token),
      headers: { "Accept" => "application/json", "Content-Type" => "application/json" }
    )
    Teachable::HttpClient.new(fake_email, fake_token).destroy("/foo/1.json")
    expect(stub).to have_been_requested
  end

  describe "without an email or token" do
    it "can be created" do
      expect(Teachable::HttpClient.new).to be_a(Teachable::HttpClient)
    end

    it "can GET data" do
      stub = stub_request(
        :get, "http://localhost:3000/foo.json"
      ).with(
        query: {},
        headers: { "Accept" => "application/json", "Content-Type" => "application/json" }
      )
      Teachable::HttpClient.new.get("/foo.json")
      expect(stub).to have_been_requested
    end

    it "can POST data" do
      body = { "foo" => "baz", "bar" => "baz" }
      stub = stub_request(
        :post, "http://localhost:3000/foo.json"
      ).with(
        query: {},
        body: hash_including(body),
        headers: { "Accept" => "application/json", "Content-Type" => "application/json" }
      )
      Teachable::HttpClient.new.post("/foo.json", body)
      expect(stub).to have_been_requested
    end

    it "can DESTROY data" do
      stub = stub_request(
        :delete, "http://localhost:3000/foo/1.json"
      ).with(
        query: {},
        headers: { "Accept" => "application/json", "Content-Type" => "application/json" }
      )
      Teachable::HttpClient.new.destroy("/foo/1.json")
      expect(stub).to have_been_requested
    end
  end
end
