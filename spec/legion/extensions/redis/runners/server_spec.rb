# frozen_string_literal: true

require 'spec_helper'
require 'legion/extensions/redis/helpers/client'
require 'legion/extensions/redis/runners/server'

RSpec.describe Legion::Extensions::Redis::Runners::Server do
  # ---------------------------------------------------------------------------
  # Concrete test class that includes the runner and provides a `client` method.
  # ---------------------------------------------------------------------------
  let(:redis_client) { double('RedisClient') }

  let(:runner_class) do
    client = redis_client
    Class.new do
      include Legion::Extensions::Redis::Runners::Server

      define_method(:client) { |**_opts| client }
    end
  end

  let(:runner) { runner_class.new }

  # ---------------------------------------------------------------------------
  describe '#keys' do
    it 'returns matching keys with the default glob *' do
      allow(redis_client).to receive(:keys).with('*').and_return(%w[a b])
      expect(runner.keys).to eq({ result: %w[a b] })
    end

    it 'accepts a custom glob pattern' do
      allow(redis_client).to receive(:keys).with('session:*').and_return(['session:1'])
      expect(runner.keys(glob: 'session:*')).to eq({ result: ['session:1'] })
    end
  end

  # ---------------------------------------------------------------------------
  describe '#ping' do
    it 'returns PONG when no message is provided' do
      allow(redis_client).to receive(:ping).with(nil).and_return('PONG')
      expect(runner.ping).to eq({ result: 'PONG' })
    end

    it 'echoes the message back when a message is provided' do
      allow(redis_client).to receive(:ping).with('hello').and_return('hello')
      expect(runner.ping(message: 'hello')).to eq({ result: 'hello' })
    end
  end

  # ---------------------------------------------------------------------------
  describe '#save' do
    it 'triggers a BGSAVE and returns OK' do
      allow(redis_client).to receive(:save).and_return('OK')
      expect(runner.save).to eq({ result: 'OK' })
    end
  end

  # ---------------------------------------------------------------------------
  describe '#time' do
    it 'returns the server time as an array' do
      allow(redis_client).to receive(:time).and_return([1_700_000_000, 123_456])
      expect(runner.time).to eq({ result: [1_700_000_000, 123_456] })
    end
  end

  # ---------------------------------------------------------------------------
  describe '#flushall' do
    it 'returns OK after flushing all databases' do
      allow(redis_client).to receive(:flushall).and_return('OK')
      expect(runner.flushall).to eq({ result: 'OK' })
    end
  end

  # ---------------------------------------------------------------------------
  describe '#flush_db' do
    it 'returns result from flushing the default db 0' do
      allow(redis_client).to receive(:flushdb).and_return('OK')
      expect(runner.flush_db).to eq({ result: 'OK' })
    end

    it 'accepts a custom db number' do
      allow(redis_client).to receive(:flushdb).and_return('OK')
      expect(runner.flush_db(db: 3)).to eq({ result: 'OK' })
    end

    it 'uses result key (not results)' do
      allow(redis_client).to receive(:flushdb).and_return('OK')
      result = runner.flush_db
      expect(result).to have_key(:result)
      expect(result).not_to have_key(:results)
    end
  end
end
