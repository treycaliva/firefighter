# Firefighter

Talk to Firebase API from Ruby:

- identity: signup, account_info, accounts_download
- realtime: read, write, add, delete data
- tokens: generate JWT tokens for token-auth

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'firefighter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install firefighter

## Usage

```ruby
# Firefighter::Identitytoolkit
# from_env uses environment variables:
# - FIREBASE_WEB_API_KEY
# - FIREBASE_SERVICE_ACCOUNT_EMAIL
identitytoolkit = Firefighter::Identitytoolkit.from_env

account = identitytoolkit.signup('test@test.de', 'totalgeheimespasswort')

account = identitytoolkit.account_info(account['idToken'])

accounts = identitytoolkit.download_accounts

token = identitytoolkit.fetch_access_token

# Firefighter::RealtimeDatabase
# from_env uses environment variables:
# - FIREBASE_WEB_DB_NAME
# - FIREBASE_WEB_DB_SECRET
realtime_database = Firefighter::RealtimeDatabase.from_env

realtime_database.write("some-path/key", {some: 'data'})

hash = realtime_database.read("some-path/key")

realtime_database.add("some-path/list", {some: 'data'})

list = realtime_database.read("some-path/list")

realtime_database.delete("some-path/list")

# Firefighter::TokenGenerator
# from_env uses environment variables:
# - FIREBASE_SERVICE_ACCOUNT_EMAIL
# - FIREBASE_SERVICE_ACCOUNT_PRIVATE_KEY
token_generator = Firefighter::TokenGenerator.from_env

access_token = token_generator.create_access_token

custom_token = token_generator.create_custom_token('someUid', data: {some: 'payload'})

payload = token_generator.read_token(custom_token)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/phoet/firefighter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Firefighter project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/phoet/firefighter/blob/master/CODE_OF_CONDUCT.md).

## Changelog

### 0.3.0

- adds `Firefighter::RealtimeDatabase#delete`
