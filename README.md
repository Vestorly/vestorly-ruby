# VestorlyApi

The Vestorly API provides the ability for external developers to synchronize their client data with Vestorly.  The API provides support for CRM integration, content curation, client behavior monitoring, and compliance monitoring software.

## Installation

Add this line to your application's Gemfile:

    gem 'vestorly_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vestorly_api

## Usage

This gem uses `ruby-redtail`, therefore, the following environment variables need to be set:

```ruby
ENV['REDTAIL_API_KEY']
ENV['REDTAIL_SECRET_KEY']
ENV['REDTAIL_API_URI']
```

### Login to Vestorly API

Login will return the authentication token on success, and if the login is invalid, it will raise `VestorlyApi::Exceptions::InvalidLoginCredentials`

**Example**: Authentication to the API

```ruby
login_api = VestorlyApi::Login.new('my@user.com', 'password')

begin
  authentication_token = login_api.login # vestorly-auth
rescue VestorlyApi::Exceptions::InvalidLoginCredentials
  # Do rescue stuff...
end
```

`VestorlyApi::Login` also provides the following public methods usable after the login was successful:

```ruby
login_api.authentication_token # vestorly-auth
login_api.advisor_id # advisor id
```

### Using the advisor API object

Once logged in with a valid login object, it can be passed to the `VestorlyApi::Advisor` to request on the advisor API part:

**Example**: Obtain the list of prospective clients for the logged in advisor

```ruby
login_api = VestorlyApi::Login.new('my@user.com', 'password')
login_api.login

advisor_api = VestorlyApi::Advisor.new(login_api)
advisor_user_entries = advisor_api.advisor_user_entries

# with query params
query_params_hash = { 'filter_by' => 'prospects' }
advisor_user_entries = advisor_api.advisor_user_entries( query_params_hash )
```

**Example**: Return a list of active advisor accounts


```ruby
login_api = VestorlyApi::Login.new('my@user.com', 'password')
login_api.login

advisor_api = VestorlyApi::Advisor.new(login_api)
advisor_posts = advisor_api.advisor_posts

# with query params
query_params_hash = { 'filter_by' => 'prospects' }
advisor_posts = advisor_api.advisor_posts(query_params_hash)
```

**NB**: The examples above asume the login was successful

## Dependencies

### Ruby

```bash
ruby 2.1.1p76
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/vestorly_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
