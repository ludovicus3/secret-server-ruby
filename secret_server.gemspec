
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'secret_server/version'

Gem::Specification.new do |spec|
  spec.name          = 'secret_server'
  spec.version       = SecretServer::VERSION
  spec.authors       = ['Tony Gambone']
  spec.email         = ['tony.gambone@thycotic.com']

  spec.summary       = 'Retrieve secrets from Secret Server in Ruby programs.'
  spec.homepage      = 'https://thycotic.com/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`
                       .split("\x0")
                       .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.52.1'

  spec.metadata = {
    "source_code_uri" => "https://github.com/thycotic/secret-server-ruby"
  }
end
