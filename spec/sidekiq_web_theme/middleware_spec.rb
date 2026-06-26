# frozen_string_literal: true

RSpec.describe SidekiqWebTheme::Middleware do
  subject(:middleware) { described_class.new(downstream) }

  let(:downstream) { -> (_env) { [status, headers, body] } }
  let(:status) { 200 }
  let(:env) { { csp_nonce: "abc123" } }

  context "when the response is an HTML page with a head" do
    let(:headers) { { "content-type" => "text/html" } }
    let(:body) { ["<html><head><title>x</title></head><body>job</body></html>"] }

    it "injects the theme CSS into the head using the CSP nonce" do
      _status, out_headers, out_body = middleware.call(env)
      html = out_body.join

      expect(html).to include(%(<style type="text/css" nonce="abc123">))
      expect(html).to include("max-width: 1200px")
      expect(html.index("</style>")).to be < html.index("</head>")
      expect(out_headers["content-length"]).to eq(html.bytesize.to_s)
    end
  end

  context "when there is no CSP nonce in env" do
    let(:env) { {} }
    let(:headers) { { "content-type" => "text/html" } }
    let(:body) { ["<html><head></head><body></body></html>"] }

    it "injects a style tag without a nonce attribute" do
      _status, _headers, out_body = middleware.call(env)

      expect(out_body.join).to include(%(<style type="text/css">))
    end
  end

  context "when the response is not HTML" do
    let(:headers) { { "content-type" => "application/json" } }
    let(:body) { ['{"ok":true}'] }

    it "passes the response through unchanged" do
      _status, _headers, out_body = middleware.call(env)

      expect(out_body.join).to eq('{"ok":true}')
      expect(out_body.join).not_to include("<style")
    end
  end

  context "when the HTML has no head tag" do
    let(:headers) { { "content-type" => "text/html" } }
    let(:body) { ["<p>no head here</p>"] }

    it "does not inject styles" do
      _status, _headers, out_body = middleware.call(env)

      expect(out_body.join).not_to include("<style")
    end
  end
end
