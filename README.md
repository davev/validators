# Validators

A collection of reusable custom ActiveRecord validators.
* Url: validates format of url string
* Email: validates format of email address


## Installation

Add this line to your application's Gemfile:

```ruby
gem "validators", :git => "https://github.com/davev/validators.git"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ git clone https://github.com/davev/validators.git
    $ cd validators && gem build validators.gemspec
    $ gem install validators-0.1.0.gem

## Usage

Examples:

```ruby
class User < ApplicationRecord
  # validates presence and format of email address
  validates :contact_email, email: true

  # validates format of url, allows blank values
  validates :twitter_url, url: true, allow_blank: true

  # custom error message
  validates :contact_email, email: { message: "invalid email address" }
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/davev/validators. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Validators project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/davev/validators/blob/master/CODE_OF_CONDUCT.md).
