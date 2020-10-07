# frozen_string_literal: true

require 'openssl'
require 'webrick'
require 'webrick/https'
require 'dotenv/load'

webrick_options = {
  Port: ENV.fetch('PORT', 3000),
  Logger: WEBrick::Log.new($stdout, WEBrick::Log::DEBUG),
  DocumentRoot: './'
  # Uncomment this if you want SSL support (you will need valid SSL certificates in the `certs/` folder).
  # SSLEnable: true,
  # SSLCertificate: OpenSSL::X509::Certificate.new(File.open('certs/public_key.pem').read),
  # SSLPrivateKey: OpenSSL::PKey::RSA.new(File.open('certs/private_key.pem').read),
  # SSLCertName: ['CN', WEBrick::Utils.getservername]
}

app = Rack::Builder.new do
  map '/' do
    use Rack::Static, urls: ['/'], root: 'public', index: 'index.html'
    run lambda { |_env|
      [
        200,
        {
          'Content-Type': 'text/html',
          'Cache-Control': 'no-cache'
        },
        File.open('public/index.html', File::RDONLY)
      ]
    }
  end
end

Signal.trap 'INT' do
  Rack::Handler::WEBrick.shutdown
end

Rack::Handler::WEBrick.run app, webrick_options
