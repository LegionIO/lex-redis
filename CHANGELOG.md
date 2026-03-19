# Changelog

## [0.2.2] - 2026-03-18

### Fixed
- `::Redis.new` constant resolution in `Helpers::Client` (was resolving to `Legion::Extensions::Redis` module instead of the Redis gem class)
- `flush_db` runner no longer passes a positional argument to `flushdb` (Redis >= 5.0 takes no args)
- `flush_db` return key changed from `results:` to `result:` to match all other runner methods
- Added `if defined?(Legion::Extensions::Helpers::Lex)` guard to `include` in both `Runners::Item` and `Runners::Server` for standalone loading

### Changed
- `Gemfile.lock` added to `.gitignore`

## [0.2.1] - 2026-03-18

### Changed
- removed needs-redis from ci workflow, deleted gemfile.lock

## [0.2.0] - 2026-03-15

### Added
- Standalone `Client` class including all runner modules
- Client accepts `host:`, `port:`, and additional kwargs at construction
- Per-call option overrides via `client(**override)`

## [0.1.1] - 2026-03-15

### Added
- Comprehensive specs for `Helpers::Client`: connection defaults, custom host/port,
  optional db and password keyword arguments
- Comprehensive specs for `Runners::Item`: get, set (with and without ttl), delete,
  exists, increment, decrement, keys (glob pattern), and rename
- Comprehensive specs for `Runners::Server`: keys, ping (with and without message),
  save, time, flushall, and flush_db (default and custom db)
- Expanded specs for `Legion::Extensions::Redis` module: version format validation

### Changed
- Version bump for GitHub migration
