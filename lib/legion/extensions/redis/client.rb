# frozen_string_literal: true

require_relative 'helpers/client'
require_relative 'runners/item'
require_relative 'runners/server'

module Legion
  module Extensions
    module Redis
      class Client
        include Runners::Item
        include Runners::Server

        attr_reader :opts

        def initialize(host: '127.0.0.1', port: 6380, **extra)
          @opts = { host: host, port: port, **extra }
        end

        def client(**override)
          Helpers::Client.client(**@opts, **override)
        end
      end
    end
  end
end
