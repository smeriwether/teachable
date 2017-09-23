require "spec_helper"

RSpec.describe Teachable::Resource do
  it "can be created" do
    expect(Teachable::Resource.new(nil)).to be_a(Teachable::Resource)
  end

  it "can transform a HTTParty array response to an array of Teachable::Model" do
    resource = Teachable::OrdersResource.new(nil)

    orders = resource.transform_all(array_response)

    expect(orders).to be_a(Array)
    expect(orders).to all(be_a(Teachable::Order))
  end

  it "can trasnform a HTTParty single instance response to a Teachable::Model" do
    resource = Teachable::OrdersResource.new(nil)
    order = resource.transform(single_response)
    expect(order).to be_a(Teachable::Order)
  end

  it "can handle a nil response from JSON.parse" do
    resource = Teachable::OrdersResource.new(nil)
    expect { resource.transform("null") }.to raise_error(Teachable::NullResponseBodyError)
  end

  def array_response
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
        "total" => "10.0",
        "total_quantity" => 100,
        "email" => "stephen@example.com",
        "special_instructions" => nil,
        "created_at" => "2017-09-23T17:57:07.510Z",
        "updated_at" => "2017-09-23T17:57:07.510Z"
      }
    ].to_json
  end

  def single_response
    {
      "id" => 841,
      "number" => "015f52f13c5267e8",
      "total" => "10.0",
      "total_quantity" => 100,
      "email" => "stephen@example.com",
      "special_instructions" => nil,
      "created_at" => "2017-09-23T17:57:25.954Z",
      "updated_at" => "2017-09-23T17:57:25.954Z"
    }.to_json
  end
end
