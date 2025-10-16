# frozen_string_literal: true

require_relative "lib/librix/version"

Gem::Specification.new do |spec|
  spec.name = "librix"
  spec.version = Librix::VERSION
  spec.authors = ["Vinicius Coelho"]
  spec.email = ["vinicoelho.dev@outlook.com"]

  spec.summary = "Gem to manage book search across multiple providers"
  spec.description = "Librix helps you search for books across multiple sources with a tiny, friendly API. Also, add more providers when you need them."
  spec.homepage = "https://github.com/viniciusscoelho/librix"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/viniciusscoelho/librix"
  spec.metadata["changelog_uri"] = "https://github.com/viniciusscoelho/librix/blob/main/CHANGELOG.md"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Runtime dependencies
  spec.add_dependency "httparty", ">= 0.21", "< 2.0"

  # Development dependencies
  spec.add_development_dependency "rake", ">= 13.0", "< 14.0"
  spec.add_development_dependency "rspec", ">= 3.0", "< 4.0"
end
