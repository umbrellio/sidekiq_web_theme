# frozen_string_literal: true

require_relative "sidekiq_web_theme/version"
require_relative "sidekiq_web_theme/middleware"

module SidekiqWebTheme
  CSS = File.read(File.expand_path("sidekiq_web_theme/style.css", __dir__)).freeze

  def self.setup!
    Sidekiq::Web.configure do |config|
      config.use(SidekiqWebTheme::Middleware)
    end
  end
end
