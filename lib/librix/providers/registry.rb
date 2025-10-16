module Librix
  module Providers
    class Registry
      @key_to_provider_class = {}

      class << self
        def register(provider_class)
          key = provider_class.new.provider_key
          @key_to_provider_class[key.to_sym] = provider_class
        end

        def fetch(key)
          klass = @key_to_provider_class[key.to_sym]
          raise Librix::Error, "Provider not found: #{key}" unless klass
          klass
        end

        def build(key)
          fetch(key).new
        end

        def keys
          @key_to_provider_class.keys
        end
      end
    end
  end
end


