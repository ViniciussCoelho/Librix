# frozen_string_literal: true

require_relative "librix/version"
require_relative "librix/configuration"
require_relative "librix/providers/base"
require_relative "librix/providers/registry"
require_relative "librix/providers/google_books"

module Librix
  class Error < StandardError; end

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.provider(key = configuration.default_provider)
    Providers::Registry.build(key)
  end

  def self.search(params, provider_key: configuration.default_provider)
    provider(provider_key).search(params)
  end
end
