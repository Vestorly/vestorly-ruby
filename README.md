# VestorlyApi

[![Gem Version](https://badge.fury.io/rb/vestorly_api.svg)](http://badge.fury.io/rb/vestorly_api)

The Vestorly API provides the ability for external developers to synchronize their client data with Vestorly.

## Installation

Add this line to your application's Gemfile:

    gem 'vestorly_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vestorly_api

## Running the tests

```bash
rspec
```

## Basic Setup

To setup the client, you'll need the following configuration.

Rails example

```ruby
VestorlyApi.configure do |config|
  config.api_uri = ENV['VESTORLY_API_URI']
end
```

### SignIn to Vestorly API

Sign in will return the authentication token on success, and if the sign_in is invalid, it will raise `VestorlyApi::Exceptions::InvalidSignInCredentials`

**Example**: Authentication to the API

```ruby
sign_in_api = VestorlyApi::SignIn.new('my@user.com', 'password')

begin
  authentication_token = sign_in_api.sign_in # vestorly-auth
rescue VestorlyApi::Exceptions::InvalidSignInCredentials
  # Do rescue stuff...
end
```

`VestorlyApi::SignIn` also provides the following public methods usable after the sign_in was successful:

```ruby
sign_in_api.authentication_token # vestorly-auth
sign_in_api.advisor_id # advisor id
```

### Using the advisor API object

Once logged in with a valid sign_in object, it can be passed to the `VestorlyApi::Advisor` to request on the advisor API part:

**Example**: Obtain the list of prospective clients for the logged in advisor

```ruby
sign_in_api = VestorlyApi::SignIn.new('my@user.com', 'password')
sign_in_api.sign_in

advisor_api = VestorlyApi::Advisor.new(sign_in_api)
advisor_user_entries = advisor_api.advisor_user_entries

# with query params
query_params_hash = { 'filter_by' => 'prospects' }
advisor_user_entries = advisor_api.advisor_user_entries( query_params_hash )
```

**Example**: Return a list of active advisor accounts


```ruby
sign_in_api = VestorlyApi::SignIn.new('my@user.com', 'password')
sign_in_api.sign_in

advisor_api = VestorlyApi::Advisor.new(sign_in_api)
advisor_posts = advisor_api.advisor_posts

# with query params
query_params_hash = { 'filter_by' => 'prospects' }
advisor_posts = advisor_api.advisor_posts(query_params_hash)
```

**Example**: Creating a new reader for the advisor

```ruby
require 'vestorly_api'

sign_in_api = VestorlyApi::SignIn.new('my@user.com', 'password')
sign_in_api.sign_in

advisor_api = VestorlyApi::AdvisorBase.new(sign_in_api)

new_member_params = {
  email: "lovecraft@gmail.com",
  first_name: "Love",
  group_id: "541c9e06c3b5a0bdda000001",
  last_name: "Craft"
}

new_member = advisor_api.create_member( new_member_params )

```

**NB**: The examples above asume the sign_in was successful


### Sign out of Vestorly API

To sign out of the Vestorly API we can use the `VestorlyApi::SigOut` object

**Example**: The sign out can be call in the 2 following forms

```ruby
# Creating an object and calling sign_out method
response = VestorlyApi::SignOut.new(authentication_token).sign_out

# Calling sig_out method on the class
response = VestorlyApi::SignOut.sign_out(authentication_token)

# response is a hash containing code and message keys
p response # { code: 202, message: "Successfully logged out." }

# with invalid authentication token
p response # { code: 404, message: "Not signed in. }
```

## Dependencies

### Ruby

```bash
ruby 2.1.1p76
```

### License  

Licensed under [MIT License](https://github.com/Vestorly/vestorly-ruby/blob/master/LICENSE.txt)

## Contributing

1. Fork it ( http://github.com/<my-github-username>/vestorly_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
