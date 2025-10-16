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

  it "builds provider from registry and searches" do
    provider = Librix.provider(:google_books)
    expect(provider.provider_key).to eq(:google_books)
    expect { Librix.search(title: "x") }.not_to raise_error
  end
end
