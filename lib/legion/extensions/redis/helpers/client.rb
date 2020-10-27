require 'redis'

module Legion
  module Extensions
    module Redis
      module Helpers
        module Client
          def self.client(host: '127.0.0.1', port: 6380, **opts)
            connect_hash = { host: host, port: port }
            connect_hash[:db] = opts[:db] if opts.key? :db
            connect_hash[:password] = opts[:password] if opts.key? :password
            Redis.new(**connect_hash)
          end
        end
      end
    end
  end
end
