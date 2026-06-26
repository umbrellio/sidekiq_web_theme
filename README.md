# sidekiq_web_theme

Usability CSS fixes for the [Sidekiq](https://github.com/sidekiq/sidekiq) Web UI.

Starting with Sidekiq 8 the default Web UI layout became less usable on wide
screens. This gem registers a small Rack middleware on `Sidekiq::Web` that
injects a stylesheet into the `<head>` of every Web UI page, constraining the
content width, shrinking oversized fonts, making job arguments scrollable and
compacting the header/footer.

The injected `<style>` tag carries the per-request CSP nonce, so it works with
Sidekiq's default `style-src 'self' 'nonce-...'` Content-Security-Policy.

## Installation

```ruby
gem "sidekiq_web_theme"
```

## Usage

Call `setup!` where `Sidekiq::Web` is mounted (e.g. `config/routes.rb` or your
Sidekiq initializer), after `sidekiq/web` is required:

```ruby
require "sidekiq/web"
require "sidekiq_web_theme"

SidekiqWebTheme.setup!
```

## Customizing the CSS

The stylesheet lives in `lib/sidekiq_web_theme/style.css` and is read once at
load time.

## License

Released under the [MIT License](LICENSE.txt).
