# frozen_string_literal: true

require 'spec_helper'
require 'legion/extensions/redis/helpers/client'
require 'legion/extensions/redis/runners/item'

RSpec.describe Legion::Extensions::Redis::Runners::Item do
  # ---------------------------------------------------------------------------
  # Build a concrete test class that includes the runner module and provides a
  # `client` instance method returning a Redis double.  The production framework
  # wires this through the actor/extension machinery; we replicate just enough
  # here to exercise every runner method.
  # ---------------------------------------------------------------------------
  let(:redis_client) { double('RedisClient') }

  let(:runner_class) do
    client = redis_client
    Class.new do
      include Legion::Extensions::Redis::Runners::Item

      define_method(:client) { |**_opts| client }
    end
  end

  let(:runner) { runner_class.new }

  # ---------------------------------------------------------------------------
  describe '#get' do
    it 'returns the value wrapped in a result hash' do
      allow(redis_client).to receive(:get).with('mykey').and_return('myvalue')
      expect(runner.get(key: 'mykey')).to eq({ result: 'myvalue' })
    end

    it 'returns nil result when the key does not exist' do
      allow(redis_client).to receive(:get).with('missing').and_return(nil)
      expect(runner.get(key: 'missing')).to eq({ result: nil })
    end
  end

  # ---------------------------------------------------------------------------
  describe '#set' do
    it 'returns OK result on success' do
      allow(redis_client).to receive(:set).with('k', 'v', ex: nil).and_return('OK')
      expect(runner.set(key: 'k', value: 'v')).to eq({ result: 'OK' })
    end

    it 'passes the ttl as ex: when provided' do
      allow(redis_client).to receive(:set).with('k', 'v', ex: 30).and_return('OK')
      result = runner.set(key: 'k', value: 'v', ttl: 30)
      expect(result).to eq({ result: 'OK' })
      expect(redis_client).to have_received(:set).with('k', 'v', ex: 30)
    end

    it 'passes nil ex: when ttl is omitted' do
      allow(redis_client).to receive(:set).with('k', 'v', ex: nil).and_return('OK')
      runner.set(key: 'k', value: 'v')
      expect(redis_client).to have_received(:set).with('k', 'v', ex: nil)
    end
  end

  # ---------------------------------------------------------------------------
  describe '#delete' do
    it 'returns the number of deleted keys' do
      allow(redis_client).to receive(:del).with('k').and_return(1)
      expect(runner.delete(key: 'k')).to eq({ result: 1 })
    end

    it 'returns 0 when the key does not exist' do
      allow(redis_client).to receive(:del).with('absent').and_return(0)
      expect(runner.delete(key: 'absent')).to eq({ result: 0 })
    end
  end

  # ---------------------------------------------------------------------------
  describe '#exists' do
    it 'returns true when the key exists' do
      allow(redis_client).to receive(:exists?).with('present').and_return(true)
      expect(runner.exists(key: 'present')).to eq({ result: true })
    end

    it 'returns false when the key does not exist' do
      allow(redis_client).to receive(:exists?).with('absent').and_return(false)
      expect(runner.exists(key: 'absent')).to eq({ result: false })
    end
  end

  # ---------------------------------------------------------------------------
  describe '#increment' do
    it 'returns the new value after incrementing by 1 by default' do
      allow(redis_client).to receive(:incrby).with('counter', 1).and_return(11)
      expect(runner.increment(key: 'counter')).to eq({ result: 11 })
    end

    it 'increments by the given number' do
      allow(redis_client).to receive(:incrby).with('counter', 5).and_return(15)
      expect(runner.increment(key: 'counter', number: 5)).to eq({ result: 15 })
    end
  end

  # ---------------------------------------------------------------------------
  describe '#decrement' do
    it 'returns the new value after decrementing by 1 by default' do
      allow(redis_client).to receive(:decrby).with('counter', 1).and_return(9)
      expect(runner.decrement(key: 'counter')).to eq({ result: 9 })
    end

    it 'decrements by the given number' do
      allow(redis_client).to receive(:decrby).with('counter', 3).and_return(7)
      expect(runner.decrement(key: 'counter', number: 3)).to eq({ result: 7 })
    end
  end

  # ---------------------------------------------------------------------------
  describe '#keys' do
    it 'returns matching keys with default glob *' do
      allow(redis_client).to receive(:keys).with('*').and_return(%w[a b c])
      expect(runner.keys).to eq({ result: %w[a b c] })
    end

    it 'accepts a custom glob pattern' do
      allow(redis_client).to receive(:keys).with('user:*').and_return(['user:1'])
      expect(runner.keys(glob: 'user:*')).to eq({ result: ['user:1'] })
    end

    it 'returns an empty array when no keys match' do
      allow(redis_client).to receive(:keys).with('none:*').and_return([])
      expect(runner.keys(glob: 'none:*')).to eq({ result: [] })
    end
  end

  # ---------------------------------------------------------------------------
  describe '#rename' do
    it 'returns OK after renaming' do
      allow(redis_client).to receive(:rename).with('old', 'new').and_return('OK')
      expect(runner.rename('old', key: 'new')).to eq({ result: 'OK' })
    end

    it 'passes the old key as the first positional argument' do
      allow(redis_client).to receive(:rename).with('src', 'dst').and_return('OK')
      runner.rename('src', key: 'dst')
      expect(redis_client).to have_received(:rename).with('src', 'dst')
    end
  end
end
