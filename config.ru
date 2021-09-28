# frozen_string_literal: true

# require 'openssl'
require 'webrick'
# require 'webrick/https'
# require 'dotenv/load'

# Listen on '/' and display the index.html
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

# Options, like port, logs, SSL config, etc..
webrick_options = {
  Port: 3000,
  Logger: WEBrick::Log.new($stdout, WEBrick::Log::INFO),
  DocumentRoot: './'
  # Uncomment this if you want SSL support (you will need valid SSL certificates in the `certs/` folder).
  # SSLEnable: true,
  # SSLCertificate: OpenSSL::X509::Certificate.new(File.open('certs/public_key.pem').read),
  # SSLPrivateKey: OpenSSL::PKey::RSA.new(File.open('certs/private_key.pem').read),
  # SSLCertName: ['CN', WEBrick::Utils.getservername]
}

# Rack::Handler::WEBrick.run(app, webrick_options)
Rack::Handler::WEBrick.run(app, **webrick_options)

# Shutdown the server with CTRL + C
Signal.trap 'INT' do
  Rack::Handler::WEBrick.shutdown
end
