module Legion
  module Extensions
    module Redis
      module Runners
        module Item
          def get(key:, **opts); end

          def delete(key:, **opts); end

          def exists(key:, **opts); end

          def keys(glob: '*', **opts); end

          def rename(old_key, key:, **opts); end

          def set(key:, value:, ttl: nil, **opts); end
        end
      end
    end
  end
end
