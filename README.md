# Librix

Librix helps you search for books across multiple sources with a tiny, friendly API. Start with Google Books; add more providers when you need them.

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
  # Default provider used by Librix.search
  config.default_provider = :google_books
end

# Search (simple API)
result = Librix.search(title: "Clean Code")

# Pick a provider when you need to
result = Librix.search({ title: "Clean Code" }, provider_key: :google_books)

# Or get the provider instance
provider = Librix.provider(:google_books)
result = provider.search(title: "Pragmatic Programmer")
```

## Requirements

- Ruby 3.1+ (3.2+ recommended).
- Dependencies: `httparty` (runtime), `rake`, `rspec` (dev).

## Configuration

Tune it as needed in `Librix.configure`:

- `google_books_api_key`: Google Books API key (optional).
- `default_provider`: default provider symbol (e.g., `:google_books`).
- `http_open_timeout`: connection open timeout in seconds (default: 2).
- `http_read_timeout`: read timeout in seconds (default: 5).
- `user_agent`: User-Agent header string (default: `librix/<version>`).
- `google_books_base_url`: Google Books base URL (default: `https://www.googleapis.com/books/v1`).

## Providers

- Default: `Librix.search(params)` uses the configured provider.
- Choose explicitly: `Librix.search(params, provider_key: :google_books)`.
- Get an instance: `Librix.provider(:google_books)`.
- See what's registered: `Librix::Providers::Registry.keys`.

### Google Books

Search by title: `search(title: "...")`.
Network and HTTP errors raise `Librix::Error` with descriptive messages.

## Errors

- `Librix::Error` wraps network/HTTP failures.
- `ArgumentError` for invalid input (e.g., missing title).

## Extending: creating a new provider

Create a class inheriting from `Librix::Providers::Base`, implement `provider_key` and `search(params)`, and register it in the `Registry`.

Minimal example:

```ruby
module Librix
  module Providers
    class OpenLibrary < Base
      def provider_key
        :open_library
      end

      def search(params)
        # implement request and return
      end

      Registry.register(self)
    end
  end
end
```

Then enable usage via:

```ruby
Librix.configure { |c| c.default_provider = :open_library }
Librix.search(title: "Clean Code")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/librix. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/librix/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
