# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Redis do
  it 'has a version number' do
    expect(Legion::Extensions::Redis::VERSION).not_to be nil
  end

  it 'has a non-empty version string' do
    expect(Legion::Extensions::Redis::VERSION).to match(/\d+\.\d+\.\d+/)
  end
end
