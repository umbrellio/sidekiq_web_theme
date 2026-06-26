# frozen_string_literal: true

require_relative "lib/sidekiq_web_theme/version"

Gem::Specification.new do |spec|
  spec.name = "sidekiq_web_theme"
  spec.version = SidekiqWebTheme::VERSION
  spec.authors = ["Umbrellio"]
  spec.email = ["oss@umbrellio.biz"]

  spec.summary = "Usability CSS fixes for the Sidekiq Web UI"
  spec.description = "Usability CSS fixes for the Sidekiq Web UI, injected via Rack middleware."
  spec.homepage = "https://github.com/umbrellio/sidekiq_web_theme"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.3"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = Dir["lib/**/*", "README.md", "LICENSE.txt", "CHANGELOG.md"]
  spec.require_paths = ["lib"]

  spec.add_dependency "sidekiq", ">= 8"
end
