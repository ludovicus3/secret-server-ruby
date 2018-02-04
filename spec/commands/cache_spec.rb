require 'spec_helper'

describe SecretServer::Commands::Cache do
  let(:client) do
    double(:fake_client).extend SecretServer::Commands::Cache
  end

  it 'retrieves cache strategy without age' do
    expect(client).to receive(:sdkclient_exec)
      .with('cache', '-c')
      .and_return("Strategy : Never\r\n")
    val = client.cache_strategy
    expect(val.length).to eql 2
    expect(val[0]).to eql SecretServer::SdkClient::StrategyNever
    expect(val[1]).to eql 0
  end

  it 'retrieves cache strategy with age' do
    expect(client).to receive(:sdkclient_exec)
      .with('cache', '-c')
      .and_return("Strategy : CacheThenServer, Max Age : 127 minutes\r\n")
    val = client.cache_strategy
    expect(val.length).to eql 2
    expect(val[0]).to eql SecretServer::SdkClient::StrategyCacheThenServer
    expect(val[1]).to eql 127
  end

  it 'retrieves cache age' do
    expect(client).to receive(:sdkclient_exec)
      .with('cache', '-c')
      .and_return("Strategy : CacheThenServer, Max Age : 127 minutes\r\n")
    val = client.cache_age
    expect(val).to eql 127
  end

  it 'clears the cache' do
    expect(client).to receive(:sdkclient_exec).with('cache', '-b')
    client.cache_clear!
  end

  it 'sets cache settings without age' do
    s = SecretServer::SdkClient::StrategyServerThenCache
    expect(client).to receive(:sdkclient_exec).with('cache', '-s', s.to_s)
    client.cache_strategy = s
  end

  it 'sets cache settings with age' do
    s = SecretServer::SdkClient::StrategyCacheThenServerAllowExpired
    expect(client).to receive(:sdkclient_exec)
      .with('cache', '-s', s.to_s, '-a', '98')
    client.cache_strategy = [s, 98]
  end

  it 'sets cache age' do
    expect(client).to receive(:sdkclient_exec).with('cache', '-a', '44')
    client.cache_age = 44
  end

  it 'rejects invalid cache settings' do
    expect { client.cache_strategy = 0, -1 }.to raise_error ArgumentError
    expect { client.cache_strategy = 0, 'foo' }.to raise_error ArgumentError
    expect { client.cache_strategy = 'foo' }.to raise_error ArgumentError
    expect { client.cache_strategy = 4 }.to raise_error ArgumentError
    expect { client.cache_strategy = -1 }.to raise_error ArgumentError
    expect { client.cache_age = nil }.to raise_error ArgumentError
    expect { client.cache_age = -1 }.to raise_error ArgumentError
    expect { client.cache_age = 'foo' }.to raise_error ArgumentError
  end
end
