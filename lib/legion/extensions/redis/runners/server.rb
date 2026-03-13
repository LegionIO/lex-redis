# frozen_string_literal: true

require 'legion/extensions/redis/helpers/client'

module Legion
  module Extensions
    module Redis
      module Runners
        module Server
          def keys(glob: '*', **)
            { result: client(**).keys(glob) }
          end

          def ping(message: nil, **)
            { result: client(**).ping(message) }
          end

          def save(**)
            { result: client(**).save }
          end

          def time(**)
            { result: client(**).time }
          end

          def flushall(**)
            { result: client(**).flushall }
          end

          def flush_db(db: 0, **)
            { results: client(db: db, **).flushdb(db) }
          end

          extend Legion::Extensions::Redis::Helpers::Client
          include Legion::Extensions::Helpers::Lex
        end
      end
    end
  end
end
