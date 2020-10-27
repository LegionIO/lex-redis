require 'legion/extensions/redis/helpers/client'

module Legion
  module Extensions
    module Redis
      module Runners
        module Item
          def get(key:, **opts)
            { result: client(**opts).get(key) }
          end

          def decrement(key:, number: 1, **opts)
            { result: client(**opts).decrby(key, number) }
          end

          def delete(key:, **opts)
            { result: client(**opts).del(key) }
          end

          def exists(key:, **opts)
            { result: client(**opts).exists?(key) }
          end

          def increment(key:, number: 1, **opts)
            { result: client(**opts).incrby(key, number) }
          end

          def keys(glob: '*', **opts)
            { result: client(**opts).keys(glob) }
          end

          def rename(old_key, key:, **opts)
            { result: client(**opts).rename(old_key, key) }
          end

          def set(key:, value:, ttl: nil, **opts)
            { result: client(**opts).set(key, value, ex: ttl) }
          end

          extend Legion::Extensions::Redis::Helpers::Client
          include Legion::Extensions::Helpers::Lex
        end
      end
    end
  end
end
