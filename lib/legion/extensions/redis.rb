# frozen_string_literal: true

require 'legion/extensions/redis/version'
require 'legion/extensions/redis/helpers/client'
require 'legion/extensions/redis/runners/item'
require 'legion/extensions/redis/runners/server'
require 'legion/extensions/redis/client'

module Legion
  module Extensions
    module Redis
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core, false
    end
  end
end
