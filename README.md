# Teachable

Teachable is my [Teachable Mock API](https://fast-bayou-75985.herokuapp.com/) client. It supports everything the API can do with a simple interface written in Ruby.

[![Build Status](https://travis-ci.org/smeriwether/teachable.svg?branch=master)](https://travis-ci.org/smeriwether/teachable)

## Installation

Add this line to your application's Gemfile:

```ruby
gem "teachable"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install teachable

## Usage

Below is a list of functions the Teachable Mock API can perform:
* User Authentication
* User Registration
* **Get Current User**
* **List All Orders**
* **Create a new Order**
* **Delete an existing Order**

*__Bold__ functions require an authenticated client*

The most common use-case will be using the authenticated client to perform actions:
```ruby
client = Teachable::Client.new(email: {email}, token: {token})
```

Actions:
```ruby
# List all Orders:
orders = client.orders.all

# Create a new Order:
new_order = Teachable::Order.new(total: 1, total_quantity: 1, email: {email})
new_order = client.orders.create(order: new_order)

# Delete an Order:
client.orders.destory(order_id: new_order.id)

# Get Current User:
current_user = client.users.current_user

# Register a new User:
new_user = client.users.register(email: {email}, password: {password}, password_confirmation: {password})

# Authenticate an existing User:
user = client.users.authenticate(email: {email}, password: {password})
```


If you don't have a token you can register using the unauthenticated client.
```ruby
unauthenticated_client = Teachable::UnauthentiatedClient.new
```

Which can before these actions:
```ruby
# Register a new User:
new_user = unauthenticated_client.users.register(email: {email}, password: {password}, password_confirmation: {password})

# Authenticate an existing User:
user = unauthenticated_client.users.authenticate(email: {email}, password: {password})
```

## Future Enhancements

These are enhancements that could be made to the gem based on need.
* Local Caching
* Automatic Failed HTTP Request Retries

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

