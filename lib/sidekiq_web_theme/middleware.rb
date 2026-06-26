# frozen_string_literal: true

module SidekiqWebTheme
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)
      return [status, headers, body] unless html_response?(headers)

      html = +""
      body.each { |part| html << part }
      body.close if body.respond_to?(:close)

      return [status, headers, [html]] unless html.include?("</head>")

      html = html.sub("</head>", "#{style_tag(env[:csp_nonce])}</head>")
      headers["content-length"] = html.bytesize.to_s

      [status, headers, [html]]
    end

    private

    def style_tag(nonce)
      nonce_attr = nonce ? %( nonce="#{nonce}") : ""
      %(<style type="text/css"#{nonce_attr}>#{SidekiqWebTheme::CSS}</style>)
    end

    def html_response?(headers)
      content_type = headers["content-type"] || headers["Content-Type"]
      content_type.to_s.include?("text/html")
    end
  end
end
