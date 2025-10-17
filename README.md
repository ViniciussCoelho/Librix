# Librix

TODO: Delete this and the text below, and describe your gem

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/librix`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add librix
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install librix
```

## Usage

```ruby
require "librix"

# Configure once (e.g., in an initializer)
Librix.configure do |config|
  config.google_books_api_key = ENV["GOOGLE_BOOKS_API_KEY"]
  # Optional tuning
  config.http_open_timeout = 2
  config.http_read_timeout = 5
  config.user_agent = "my-app/1.0"
# Default provider is :google_books. You can set a default globally:
  config.provider = :google_books
end

# Or request one explicitly at call-site:
provider = Librix.provider(:google_books)
result = provider.search(title: "Clean Code")

# Available providers
# Librix::Providers::Factory.available #=> [:google_books]

# Registering a custom provider
# class MyProvider
#   def search(params)
#     # ...
#   end
# end
# Librix::Providers::Factory.register(:my_provider, MyProvider)
# provider = Librix.provider(:my_provider)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/librix. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/librix/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
