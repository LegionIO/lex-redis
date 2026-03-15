# frozen_string_literal: true

require 'spec_helper'
require 'legion/extensions/redis/client'

RSpec.describe Legion::Extensions::Redis::Client do
  let(:mock_redis) { double('RedisClient') }

  before do
    allow(Legion::Extensions::Redis::Helpers::Client).to receive(:client).and_return(mock_redis)
  end

  describe '#initialize' do
    it 'stores default options' do
      client = described_class.new
      expect(client.opts).to eq({ host: '127.0.0.1', port: 6380 })
    end

    it 'accepts custom options' do
      client = described_class.new(host: '10.0.0.1', port: 6379, db: 2)
      expect(client.opts).to include(host: '10.0.0.1', port: 6379, db: 2)
    end
  end

  describe '#client' do
    it 'delegates to Helpers::Client.client with merged opts' do
      client = described_class.new(host: 'redis.local', port: 6379)

      result = client.client
      expect(Legion::Extensions::Redis::Helpers::Client).to have_received(:client).with(host: 'redis.local', port: 6379)
      expect(result).to eq(mock_redis)
    end

    it 'allows per-call overrides' do
      client = described_class.new(host: 'redis.local', port: 6379)

      client.client(db: 5)
      expect(Legion::Extensions::Redis::Helpers::Client).to have_received(:client).with(host: 'redis.local', port: 6379, db: 5)
    end
  end

  describe 'runner methods' do
    let(:client_instance) { described_class.new }

    it 'responds to Item runner methods' do
      expect(client_instance).to respond_to(:get, :set, :delete, :exists, :increment, :decrement, :keys, :rename)
    end

    it 'responds to Server runner methods' do
      expect(client_instance).to respond_to(:ping, :save, :time, :flushall, :flush_db)
    end

    it 'can call get through the client' do
      allow(mock_redis).to receive(:get).with('test_key').and_return('test_value')
      result = client_instance.get(key: 'test_key')
      expect(result[:result]).to eq('test_value')
    end

    it 'can call set through the client' do
      allow(mock_redis).to receive(:set).with('test_key', 'test_value', ex: nil).and_return('OK')
      result = client_instance.set(key: 'test_key', value: 'test_value')
      expect(result[:result]).to eq('OK')
    end

    it 'can call ping through the client' do
      allow(mock_redis).to receive(:ping).with(nil).and_return('PONG')
      result = client_instance.ping
      expect(result[:result]).to eq('PONG')
    end
  end
end
