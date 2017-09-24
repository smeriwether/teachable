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

  it "raises an error when a GET request is unsuccessful" do
    stub_request(:get, "http://localhost:3000/foo/1.json").to_return(body: "foo", status: 422)
    expect { Teachable::HttpClient.new.get("/foo/1.json") }.
      to raise_error(Teachable::UnsucessfulRequestError)
  end

  it "raises an error when a POST request is unsuccessful" do
    stub_request(:post, "http://localhost:3000/foo/1.json").to_return(body: "foo", status: 422)
    expect { Teachable::HttpClient.new.post("/foo/1.json", {}) }.
      to raise_error(Teachable::UnsucessfulRequestError)
  end

  it "raises an error when a DESTROY request is unsuccessful" do
    stub_request(:delete, "http://localhost:3000/foo/1.json").to_return(body: "foo", status: 422)
    expect { Teachable::HttpClient.new.destroy("/foo/1.json") }.
      to raise_error(Teachable::UnsucessfulRequestError)
  end

  it "encodes the email and token" do
    fake_email = "foo+1@example.com"
    fake_token = "foobar+baz"
    stub = stub_request(
      :get, "http://localhost:3000/foo.json?user_email=foo%2B1@example.com&user_token=foobar%2Bbaz"
    )
    Teachable::HttpClient.new(fake_email, fake_token).get("/foo.json")
    expect(stub).to have_been_requested
  end
end
