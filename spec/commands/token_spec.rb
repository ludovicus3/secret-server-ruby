require 'spec_helper'

describe SecretServer::Commands::Token do
  let(:client) do
    double(:fake_client).extend SecretServer::Commands::Token
  end

  it 'fetches an API token' do
    expect(client).to receive(:sdkclient_exec).with('token').and_return('123')
    val = client.token
    expect(val).to eql '123'
  end
end
