require_relative 'lib/legion/extensions/redis/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-redis'
  spec.version       = Legion::Extensions::Redis::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']

  spec.summary       = 'LEX::redis'
  spec.description   = 'LEX::redis'
  spec.homepage      = 'https://bitbucket.org/legion-io/lex-redis'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://bitbucket.org/legion-io/lex-redis'
  spec.metadata['documentation_uri'] = 'https://legionio.atlassian.net/wiki/spaces/LEX/pages/614891585'
  spec.metadata['changelog_uri'] = 'https://legionio.atlassian.net/wiki/spaces/LEX/pages/612270191'
  spec.metadata['bug_tracker_uri'] = 'https://bitbucket.org/legion-io/lex-redis/issues'
  spec.require_paths = ['lib']
end
