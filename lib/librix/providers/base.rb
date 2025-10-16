module Librix
  module Providers
    class Base
      def initialize
        @config = Librix.configuration
      end

      def provider_key
        raise NotImplementedError, "Provider must implement #provider_key"
      end

      def search(params)
        raise NotImplementedError, "Provider must implement #search(params)"
      end
    end
  end
end


