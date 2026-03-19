# frozen_string_literal: true

require 'spec_helper'
require 'legion/extensions/redis/helpers/client'

RSpec.describe Legion::Extensions::Redis::Helpers::Client do
  let(:redis_double) { double('RedisClient') }

  before do
    allow(Redis).to receive(:new).and_return(redis_double)
  end

  describe '.client' do
    it 'returns a Redis client' do
      expect(described_class.client).to eq(redis_double)
    end

    it 'uses the default host 127.0.0.1' do
      described_class.client
      expect(Redis).to have_received(:new).with(hash_including(host: '127.0.0.1'))
    end

    it 'uses the default port 6380' do
      described_class.client
      expect(Redis).to have_received(:new).with(hash_including(port: 6380))
    end

    it 'accepts a custom host' do
      described_class.client(host: '10.0.0.5')
      expect(Redis).to have_received(:new).with(hash_including(host: '10.0.0.5'))
    end

    it 'accepts a custom port' do
      described_class.client(port: 6379)
      expect(Redis).to have_received(:new).with(hash_including(port: 6379))
    end

    it 'includes db in the connect hash when provided' do
      described_class.client(db: 2)
      expect(Redis).to have_received(:new).with(hash_including(db: 2))
    end

    it 'omits db from the connect hash when not provided' do
      described_class.client
      expect(Redis).to have_received(:new).with(hash_excluding(:db))
    end

    it 'includes password in the connect hash when provided' do
      described_class.client(password: 's3cr3t')
      expect(Redis).to have_received(:new).with(hash_including(password: 's3cr3t'))
    end

    it 'omits password from the connect hash when not provided' do
      described_class.client
      expect(Redis).to have_received(:new).with(hash_excluding(:password))
    end

    it 'passes both db and password when both are provided' do
      described_class.client(db: 1, password: 'pass')
      expect(Redis).to have_received(:new).with(
        hash_including(db: 1, password: 'pass')
      )
    end
  end
end
