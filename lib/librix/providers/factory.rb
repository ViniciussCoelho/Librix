module Librix
  module Providers
    class Factory
      class << self
        def register(key, klass)
          registry[key.to_sym] = klass
        end

        def build(name = nil)
          provider_key = (name || Librix.configuration.provider || :google_books).to_sym
          klass = registry[provider_key]
          raise ArgumentError, "Unknown provider: #{provider_key}" unless klass
          klass.new
        end

        def available
          registry.keys
        end

        private

        def registry
          @registry ||= {
            google_books: Librix::Providers::GoogleBooks
          }
        end
      end
    end
  end
end


