# lex-redis: Redis Integration for LegionIO

**Repository Level 3 Documentation**
- **Category**: `/Users/miverso2/rubymine/legion/extensions/CLAUDE.md`

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
    └── Client             # Redis client connection helper
```

## Dependencies

| Gem | Purpose |
|-----|---------|
| `redis` | Redis Ruby client |

## Testing

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

---

**Maintained By**: Matthew Iverson (@Esity)
