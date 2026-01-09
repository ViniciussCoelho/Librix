# frozen_string_literal: true

require_relative "librix/version"
require_relative "librix/configuration"
require_relative "librix/providers/google_books"
require_relative "librix/providers/open_library"
require_relative "librix/providers/factory"

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

  def self.provider(name = nil)
    Librix::Providers::Factory.build(name)
  end
end
