# frozen_string_literal: true

require 'webrick'
require 'rack'
require 'rackup'

# Uncomment this if you want SSL support
# require 'openssl'
# require 'webrick/https'
# require 'dotenv/load'

# SSL_PUBLIC_KEY = File.read('certs/public_key.pem')
# SSL_PRIVATE_KEY = File.read('certs/private_key.pem')

# Listen on '/' and display the index.html
app = Rack::Builder.new do
  map '/' do
    use Rack::Static, urls: ['/'], root: 'public', index: 'index.html'
    run do |_env|
      [
        200,
        {
          'Content-Type': 'text/html',
          'Cache-Control': 'no-cache'
        },
        File.open('public/index.html', File::RDONLY)
      ]
    end
  end
end

# Options, like port, logs, SSL config, etc..
webrick_options = {
  Port: 3000,
  Logger: WEBrick::Log.new($stdout, WEBrick::Log::INFO),
  DocumentRoot: './'
  # Uncomment this if you want SSL support (you will need valid SSL certificates in the `certs/` folder).
  # SSLEnable: true,
  # SSLCertificate: OpenSSL::X509::Certificate.new(SSL_PUBLIC_KEY),
  # SSLPrivateKey: OpenSSL::PKey::RSA.new(SSL_PRIVATE_KEY),
  # SSLCertName: ['CN', WEBrick::Utils.getservername]
}

# Rack::Handler::WEBrick.run(app, webrick_options)
Rackup::Handler::WEBrick.run(app, **webrick_options)

# Shutdown the server with CTRL + C
Signal.trap 'INT' do
  Rackup::Handler::WEBrick.shutdown
end
