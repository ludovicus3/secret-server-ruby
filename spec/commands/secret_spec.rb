require 'spec_helper'

describe SecretServer::Commands::Secret do
  let(:client) do
    double(:fake_client).extend SecretServer::Commands::Secret
  end

  it 'fetches a secret field' do
    expect(client).to receive(:sdkclient_exec)
      .with('secret', '-s', '99', '-f', 'password')
      .and_return 'blah'
    val = client.secret(99, field: 'password')
    expect(val).to eql 'blah'
  end

  it 'fetches all secret fields' do
    expect(client).to receive(:sdkclient_exec)
      .with('secret', '-s', '99', '-ad')
      .and_return '{"a":"b"}'
    val = client.secret(99, field: :all)
    expect(val).to include 'a'
    expect(val['a']).to eql 'b'
  end

  it 'fetches full secret JSON' do
    expect(client).to receive(:sdkclient_exec)
      .with('secret', '-s', '99')
      .and_return '{"a":"b"}'
    val = client.secret(99)
    expect(val).to include 'a'
    expect(val['a']).to eql 'b'
  end

  it 'rejects invalid arguments' do
    expect { client.secret(-1) }.to raise_error ArgumentError
    expect { client.secret('foo') }.to raise_error ArgumentError
  end

  it 'chomps output' do
    expect(client).to receive(:sdkclient_exec)
      .with('secret', '-s', '99', '-f', 'password')
      .and_return "blah\r\n"
    val = client.secret(99, field: 'password')
    expect(val).to eql 'blah'
  end
end
