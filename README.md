# Librix — Your Friendly Book API Librarian

**Librix** is a Ruby gem that makes working with book APIs easy.  
Instead of juggling different endpoints and data formats from places like Google Books, Open Library, or Goodreads, Librix gives you one clean, consistent interface to work with.

With Librix, you can:

- Connect to multiple book APIs through a single, unified interface  
- Search for titles, authors, descriptions, and covers without the usual API chaos  
- Get clean, consistent responses no matter where the data comes from  
- Add new API integrations easily, without touching your core logic  

## Installation

```bash
bundle add librix
```

OR

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

## Contributing

Bug reports and pull requests are welcome.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
