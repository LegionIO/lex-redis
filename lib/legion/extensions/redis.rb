require 'legion/extensions/redis/version'

module Legion
  module Extensions
    module Redis
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
