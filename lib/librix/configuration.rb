module Librix
  class Configuration
    attr_accessor :google_books_api_key,
                  :goodreads_api_key,
                  :open_library_enabled,
                  :provider,
                  :http_open_timeout,
                  :http_read_timeout,
                  :user_agent,
                  :google_books_base_url

    def initialize
      @open_library_enabled = false
      @http_open_timeout = 2
      @http_read_timeout = 5
      @user_agent = "librix/#{Librix::VERSION}"
      @google_books_base_url = "https://www.googleapis.com/books/v1"
      @provider = :google_books
    end
  end
end