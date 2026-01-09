require 'uri'
require 'httparty'

module Librix
  module Providers
    class OpenLibrary
      include HTTParty

      base_uri 'https://openlibrary.org'
      COVER_BASE = 'https://covers.openlibrary.org/b'.freeze

      def search(query, limit: 10)
        response = self.class.get(
          '/search.json',
          query: {
            q: query,
            limit: limit
          }
        )

        response.success? ? response.parsed_response['docs'] : []
      end

      def cover_url(isbn: nil, cover_id: nil, olid: nil, size: 'M')
        return cover_by_isbn(isbn, size) if isbn.present?
        return cover_by_cover_id(cover_id, size) if cover_id.present?
        return cover_by_olid(olid, size) if olid.present?

        nil
      end

      private

      def cover_by_isbn(isbn, size)
        "#{COVER_BASE}/ISBN/#{isbn}-#{size}.jpg?default=false"
      end

      def cover_by_cover_id(cover_id, size)
        "#{COVER_BASE}/id/#{cover_id}-#{size}.jpg?default=false"
      end

      def cover_by_olid(olid, size)
        "#{COVER_BASE}/OLID/#{olid}-#{size}.jpg?default=false"
      end
    end
  end
end
