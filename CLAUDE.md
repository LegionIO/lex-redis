# lex-redis: Redis Integration for LegionIO

**Repository Level 3 Documentation**
- **Parent (Level 2)**: `/Users/miverso2/rubymine/legion/extensions/CLAUDE.md`
- **Parent (Level 1)**: `/Users/miverso2/rubymine/legion/CLAUDE.md`

## Purpose

Legion Extension that connects LegionIO to Redis servers. Provides runners for item-level key/value operations and server management.

**Version**: 0.2.3
**GitHub**: https://github.com/LegionIO/lex-redis
**License**: MIT

## Architecture

```
Legion::Extensions::Redis
├── Runners/
│   ├── Item               # Key/value operations (get, set, delete, etc.)
│   └── Server             # Server management and info
├── Helpers/
│   └── Client             # Redis client connection helper (module method: .client)
└── Client                 # Standalone client class wrapping Helpers::Client + all runners
```

## Key Files

| Path | Purpose |
|------|---------|
| `lib/legion/extensions/redis.rb` | Entry point, extension registration |
| `lib/legion/extensions/redis/runners/item.rb` | Key/value runner |
| `lib/legion/extensions/redis/runners/server.rb` | Server management runner |
| `lib/legion/extensions/redis/helpers/client.rb` | Redis connection builder |
| `lib/legion/extensions/redis/client.rb` | Standalone `Client` class for use outside Legion framework |

## Runner Methods

**Item** (`lib/legion/extensions/redis/runners/item.rb`): `get`, `set` (with optional `ttl:`), `delete`, `exists`, `increment`, `decrement`, `keys`, `rename`

**Server** (`lib/legion/extensions/redis/runners/server.rb`): `ping`, `save`, `time`, `flushall`, `flush_db`, `keys`

Both runners use `extend Legion::Extensions::Redis::Helpers::Client` so `client(**kwargs)` is available as a module-level method.

## Connection Defaults

`Helpers::Client.client` defaults: `host: '127.0.0.1'`, `port: 6380`. Note the non-standard default port of 6380 (not the Redis default 6379). Pass `host:`, `port:`, `db:`, and `password:` in task payloads to override.

`Helpers::Client` uses `::Redis.new` (fully qualified) to avoid the constant resolving to `Legion::Extensions::Redis` instead of the Redis gem class. `flush_db` calls `redis.flushdb` with no arguments (Redis >= 5.0). Return key for `flush_db` is `result:` (not `results:`).

## Standalone Client

`Client` wraps `Helpers::Client` and includes all runners (`Item`, `Server`), enabling use as a standalone Redis client outside the full LegionIO framework.

## Dependencies

| Gem | Purpose |
|-----|---------|
| `redis` | Redis Ruby client (>= 5.0) |

## Testing

49 specs across 5 spec files.

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

---

**Maintained By**: Matthew Iverson (@Esity)
