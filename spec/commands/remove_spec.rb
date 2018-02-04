require 'spec_helper'

describe SecretServer::Commands::Remove do
  let(:client) do
    double(:fake_client).extend SecretServer::Commands::Remove
  end

  it 'removes client settings' do
    expect(client).to receive(:sdkclient_exec).with('remove', '-c')
    client.remove!
  end
end
