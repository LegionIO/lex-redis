# frozen_string_literal: true

require 'legion/extensions/redis/helpers/client'

module Legion
  module Extensions
    module Redis
      module Runners
        module Item
          def get(key:, **)
            { result: client(**).get(key) }
          end

          def decrement(key:, number: 1, **)
            { result: client(**).decrby(key, number) }
          end

          def delete(key:, **)
            { result: client(**).del(key) }
          end

          def exists(key:, **)
            { result: client(**).exists?(key) }
          end

          def increment(key:, number: 1, **)
            { result: client(**).incrby(key, number) }
          end

          def keys(glob: '*', **)
            { result: client(**).keys(glob) }
          end

          def rename(old_key, key:, **)
            { result: client(**).rename(old_key, key) }
          end

          def set(key:, value:, ttl: nil, **)
            { result: client(**).set(key, value, ex: ttl) }
          end

          extend Legion::Extensions::Redis::Helpers::Client
          include Legion::Extensions::Helpers::Lex
        end
      end
    end
  end
end
