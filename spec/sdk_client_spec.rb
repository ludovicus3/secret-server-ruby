require 'spec_helper'

describe SecretServer::SdkClient do
  it 'has a version number' do
    expect(SecretServer::VERSION).not_to be nil
  end

  it 'includes all commands' do
    expect(SecretServer.respond_to?(:cache_age)).to be true
    expect(SecretServer.respond_to?(:init!)).to be true
    expect(SecretServer.respond_to?(:remove!)).to be true
    expect(SecretServer.respond_to?(:secret)).to be true
    expect(SecretServer.respond_to?(:token)).to be true
  end

  it 'accepts environment configuration' do
    ENV['SDK_CLIENT_PATH'] = '/foo'
    ENV['SECRET_SERVER_URL'] = 'https://example.com'
    ENV['SDK_CLIENT_RULE'] = 'MyRule'
    ENV['SDK_CLIENT_KEY'] = 'MyKey'
    SecretServer.env_configure
    expect(SecretServer.path).to eql '/foo'
    expect(SecretServer.url).to eql 'https://example.com'
    expect(SecretServer.rule).to eql 'MyRule'
    expect(SecretServer.key).to eql 'MyKey'
  end
end
