# lex-redis: Redis Integration for LegionIO

**Repository Level 3 Documentation**
- **Parent (Level 2)**: `/Users/miverso2/rubymine/legion/extensions/CLAUDE.md`
- **Parent (Level 1)**: `/Users/miverso2/rubymine/legion/CLAUDE.md`

## Purpose

Legion Extension that connects LegionIO to Redis servers. Provides runners for item-level key/value operations and server management.

**GitHub**: https://github.com/LegionIO/lex-redis
**License**: MIT

## Architecture

```
Legion::Extensions::Redis
├── Runners/
│   ├── Item               # Key/value operations (get, set, delete, etc.)
│   └── Server             # Server management and info
└── Helpers/
    └── Client             # Redis client connection helper (module method: .client)
```

## Runner Methods

**Item** (`lib/legion/extensions/redis/runners/item.rb`): `get`, `set` (with optional `ttl:`), `delete`, `exists`, `increment`, `decrement`, `keys`, `rename`

**Server** (`lib/legion/extensions/redis/runners/server.rb`): `ping`, `save`, `time`, `flushall`, `flush_db`, `keys`

Both runners use `extend Legion::Extensions::Redis::Helpers::Client` so `client(**kwargs)` is available as a module-level method.

## Connection Defaults

`Helpers::Client.client` defaults: `host: '127.0.0.1'`, `port: 6380`. Note the non-standard default port of 6380 (not the Redis default 6379). Pass `host:`, `port:`, `db:`, and `password:` in task payloads to override.

## Dependencies

| Gem | Purpose |
|-----|---------|
| `redis` | Redis Ruby client (>= 5.0) |

## Testing

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

---

**Maintained By**: Matthew Iverson (@Esity)
