require "uri"
require "httparty"

module Librix
  module Providers
    class GoogleBooks < Base
      def initialize
        @config = Librix.configuration
        @api_key = @config.google_books_api_key
      end

      def provider_key
        :google_books
      end

      def search(params)
        raise ArgumentError, "title is required" unless params && params[:title].to_s.strip != ""

        base = @config.google_books_base_url
        query = URI.encode_www_form(q: params[:title])
        url = "#{base}/volumes?#{query}"

        headers = { "User-Agent" => @config.user_agent }
        options = {
          headers: headers,
          timeout: @config.http_read_timeout,
          open_timeout: @config.http_open_timeout,
          query: (@api_key ? { key: @api_key } : {})
        }

        response = HTTParty.get(url, options)

        unless response.success?
          raise Librix::Error, "GoogleBooks HTTP #{response.code}: #{safe_body_snippet(response)}"
        end

        response.parsed_response
      rescue Net::OpenTimeout, Net::ReadTimeout => e
        raise Librix::Error, "GoogleBooks timeout: #{e.message}"
      rescue SocketError, Errno::ECONNREFUSED => e
        raise Librix::Error, "GoogleBooks connection failed: #{e.message}"
      end

      private

      def safe_body_snippet(response)
        body = response&.body.to_s
        body.length > 200 ? body[0, 200] + "..." : body
      end

      Registry.register(self)
    end
  end
end