require "spec_helper"

RSpec.describe Teachable::User do
  it "can be created" do
    expect(Teachable::User.new).to be_a(Teachable::User)
  end

  it "fields can be changed after new" do
    user = Teachable::User.new
    user.id = 1
    user.name = "Example"
    user.nickname = "Exam"
    user.image = nil
    user.email = "example@example.com"
    user.tokens = "abcdef"

    expect(user.id).to eq(1)
    expect(user.name).to eq("Example")
    expect(user.nickname).to eq("Exam")
    expect(user.image).to eq(nil)
    expect(user.email).to eq("example@example.com")
    expect(user.tokens).to eq("abcdef")
  end

  it "can be hashed" do
    user = Teachable::User.new(
      id: 1,
      name: "foo",
      nickname: "bar",
      image: "baz",
      email: "example@example.com",
      tokens: "abcdef"
    )

    hash = user.to_hash

    expect(hash).to match(
      id: 1,
      name: "foo",
      nickname: "bar",
      image: "baz",
      email: "example@example.com",
      tokens: "abcdef"
    )
  end
end
