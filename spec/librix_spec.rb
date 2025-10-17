# frozen_string_literal: true

RSpec.describe Librix do
  it "has a version number" do
    expect(Librix::VERSION).not_to be nil
  end

  it "exposes configuration and configure" do
    Librix.configure do |config|
      config.google_books_api_key = "test"
    end

    expect(Librix.configuration.google_books_api_key).to eq("test")
    expect(Librix.configuration.user_agent).to include("librix/")
  end

  it "builds default provider via factory" do
    Librix.configure do |config|
      config.provider = :google_books
    end

    provider = Librix.provider
    expect(provider).to be_a(Librix::Providers::GoogleBooks)
  end

  it "builds provider by explicit name" do
    provider = Librix.provider(:google_books)
    expect(provider).to be_a(Librix::Providers::GoogleBooks)
  end
end
