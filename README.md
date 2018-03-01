# secret-server-ruby

A gem for using Thycotic Secret Server as a vault for storing secrets and consuming them in Ruby programs.

Requires Secret Server 10.4 and higher, and an installation of the Secret Server SDK client tool.

This gem is unofficial and not supported by Thycotic.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'secret_server'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install secret_server

## Initial Setup

Configure the connection to your Secret Server instance:

```ruby
SecretServer.configure do |config|
  config.path = "#{ENV['HOME']}/sdkclient"
  config.url = 'https://myserver/SecretServer/'
  config.rule = 'MyOnboardingRule'
  config.key = 'MyOnboardingKey'
end
```

* `config.path` is the directory containing the SDK client
* `config.url` is the URL to your Secret Server instance
* `config.rule` is the name of an onboarding rule you have created (optional)
* `config.key` is the onboarding key for that rule, if applicable (optional)

Alternatively, you can also pull configuration from the current environment:

```ruby
SecretServer.env_configure
```

The gem will configure the connection using the variables `SDK_CLIENT_PATH`,
`SECRET_SERVER_URL`, `SDK_CLIENT_RULE`, and `SDK_CLIENT_KEY`.

Initialize the connection to Secret Server:

```ruby
SecretServer.init!
```

The initialization step requires write access to the current directory.

Once the configuration and initialization are complete, they do not need to be
run again. Encrypted configuration files created in the current directory will
be used to establish the connection to Secret Server.

## Usage

Fetch a secret by ID:

```ruby
# retrieve the full representation of a secret
secret = SecretServer.secret(1)

# retrieve only the secret fields
secret = SecretServer.secret(1, field: :all)

# retrieve only a single secret field value by slug
password = SecretServer.secret(1, field: 'password')
```

To acquire an API token to make REST calls as the application account user:

```ruby
token = SecretServer.token
```

To remove the connection to Secret Server and delete all configuration:

```ruby
SecretServer.remove!
```

## Cache Settings

By default, no secret values are stored on the local machine. As such, every call to `SecretServer.secret` will result in a round-trip to the server.  If the server is unavailable, the call will fail.

To change this behavior, set the cache strategy:

```ruby
# The default (never cache secrets)
SecretServer.cache_strategy = SecretServer::SdkClient::StrategyNever

# Set the cache age (the maximum time, in minutes, that a cached value will be usable).
SecretServer.cache_age = 10

# Check the server first; if unavailable, use the return the last retrieved
# value, if present. Use this strategy for improved fault tolerance.
SecretServer.cache_strategy = SecretServer::SdkClient::StrategyServerThenCache

# Check the cache first; if no value is present, retrieve it from the server.
# Use this strategy for improved performance.
SecretServer.cache_strategy = SecretServer::SdkClient::StrategyCacheThenServer

# Same as the above mode, but allow an expired cached value to be used if the
# server is unavailable.
SecretServer.cache_strategy = SecretServer::SdkClient::StrategyCacheThenServerAllowExpired

# It is also possible to set the cache strategy and age at the same time:
SecretServer.cache_strategy = [SecretServer::SdkClient::StrategyServerThenCache, 20]

# Clear all cached values immediately
SecretServer.cache_clear!
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/thycotic/secret-server-ruby.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
