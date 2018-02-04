require 'spec_helper'

describe SecretServer::Commands::Init do
  let(:client) do
    double(:fake_client).extend SecretServer::Commands::Init
  end

  it 'requires a configured URL' do
    expect(client).to receive(:valid_url?)
      .with(no_args)
      .and_return(false)
    expect { client.init! }.to raise_error RuntimeError
  end

  it 'performs basic initialization' do
    expect(client).to receive(:valid_url?)
      .with(no_args)
      .and_return(true)
    expect(client).to receive(:url)
      .with(no_args)
      .and_return('foo')
    expect(client).to receive(:rule)
      .at_least(:once)
      .with(no_args)
      .and_return(nil)
    expect(client).to receive(:key)
      .at_least(:once)
      .with(no_args)
      .and_return(nil)
    expect(client).to receive(:sdkclient_exec)
      .with('init', '-e', '-u', 'foo')
    client.init!
  end

  it 'performs initialization with rule' do
    expect(client).to receive(:valid_url?)
      .with(no_args)
      .and_return(true)
    expect(client).to receive(:url)
      .with(no_args)
      .and_return('foo')
    expect(client).to receive(:rule)
      .at_least(:once)
      .with(no_args)
      .and_return('bar')
    expect(client).to receive(:key)
      .at_least(:once)
      .with(no_args)
      .and_return(nil)
    expect(client).to receive(:sdkclient_exec)
      .with('init', '-e', '-u', 'foo', '-r', 'bar')
    client.init!
  end

  it 'performs initialization with key' do
    expect(client).to receive(:valid_url?)
      .with(no_args)
      .and_return(true)
    expect(client).to receive(:url)
      .with(no_args)
      .and_return('foo')
    expect(client).to receive(:rule)
      .at_least(:once)
      .with(no_args)
      .and_return(nil)
    expect(client).to receive(:key)
      .at_least(:once)
      .with(no_args)
      .and_return('bar')
    expect(client).to receive(:sdkclient_exec)
      .with('init', '-e', '-u', 'foo', '-k', 'bar')
    client.init!
  end

  it 'performs initialization with rule and key' do
    expect(client).to receive(:valid_url?)
      .with(no_args)
      .and_return(true)
    expect(client).to receive(:url)
      .with(no_args)
      .and_return('foo')
    expect(client).to receive(:rule)
      .at_least(:once)
      .with(no_args)
      .and_return('bar')
    expect(client).to receive(:key)
      .at_least(:once)
      .with(no_args)
      .and_return('baz')
    expect(client).to receive(:sdkclient_exec)
      .with('init', '-e', '-u', 'foo', '-r', 'bar', '-k', 'baz')
    client.init!
  end
end
