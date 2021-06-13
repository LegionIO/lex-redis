require_relative 'lib/legion/extensions/redis/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-redis'
  spec.version       = Legion::Extensions::Redis::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']

  spec.summary       = 'LEX::redis'
  spec.description   = 'Connects LegionIO to Redis Servers'
  spec.homepage      = 'https://github.com/LegionIO/lex-redis'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/LegionIO/lex-redis'
  spec.metadata['documentation_uri'] = 'https://github.com/LegionIO/lex-redis'
  spec.metadata['changelog_uri'] = 'https://github.com/LegionIO/lex-redis'
  spec.metadata['bug_tracker_uri'] = 'https://github.com/LegionIO/lex-redis/issues'
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']
  spec.add_dependency 'redis'
end
