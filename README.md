# lex-redis

Redis integration for [LegionIO](https://github.com/LegionIO/LegionIO). Run key/value operations and server management commands against Redis servers from within task chains.

## Installation

```bash
gem install lex-redis
```

## Functions

### Item Runner (key/value operations)

| Function | Parameters | Description |
|----------|-----------|-------------|
| `get` | `key:` | Get value by key |
| `set` | `key:`, `value:`, `ttl:` (optional) | Set key to value, with optional TTL in seconds |
| `delete` | `key:` | Delete a key |
| `exists` | `key:` | Check if a key exists (returns boolean) |
| `increment` | `key:`, `number:` (default: 1) | Increment key by number |
| `decrement` | `key:`, `number:` (default: 1) | Decrement key by number |
| `keys` | `glob:` (default: `'*'`) | List keys matching a glob pattern |
| `rename` | `old_key`, `key:` | Rename a key |

### Server Runner (server management)

| Function | Parameters | Description |
|----------|-----------|-------------|
| `ping` | `message:` (optional) | Ping the server |
| `save` | (none) | Trigger a blocking BGSAVE |
| `time` | (none) | Return server time |
| `flushall` | (none) | Flush all databases |
| `flush_db` | `db:` (default: 0) | Flush a specific database |
| `keys` | `glob:` (default: `'*'`) | List keys matching a glob pattern |

### Connection Parameters

All runners accept connection kwargs forwarded to `Helpers::Client`:

| Parameter | Default | Description |
|-----------|---------|-------------|
| `host` | `'127.0.0.1'` | Redis server hostname |
| `port` | `6380` | Redis server port |
| `db` | (none) | Database number |
| `password` | (none) | Auth password |

Note: the default port is `6380`, not the standard Redis default of `6379`.

## Requirements

- Ruby >= 3.4
- [LegionIO](https://github.com/LegionIO/LegionIO) framework
- Redis server >= 5.0

## License

MIT
