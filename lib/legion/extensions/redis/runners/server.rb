require 'legion/extensions/redis/helpers/client'

module Legion
  module Extensions
    module Redis
      module Runners
        module Server
          def keys(glob: '*', **opts)
            { result: client(**opts).keys(glob) }
          end

          def ping(message: nil, **opts)
            { result: client(**opts).ping(message) }
          end

          def save(**opts)
            { result: client(**opts).save }
          end

          def time(**opts)
            { result: client(**opts).time }
          end

          def flushall(**opts)
            { result: client(**opts).flushall }
          end

          def flush_db(db: 0, **opts)
            { results: client(db: db, **opts).flushdb(db) }
          end

          extend Legion::Extensions::Redis::Helpers::Client
          include Legion::Extensions::Helpers::Lex
        end
      end
    end
  end
end
