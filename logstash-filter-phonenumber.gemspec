Gem::Specification.new do |s|
  s.name          = 'logstash-filter-phonenumber'
  s.version       = '1.0.0'
  s.licenses      = ['Apache-2.0']
  s.summary       = 'Parse phonenumber to extract country and more.'
  s.homepage      = 'https://github.com/alkivi-sas/logstash-filter-phonenumber'
  s.authors       = ['Alkivi']
  s.email         = 'anthony@alkivi.fr'
  s.require_paths = ['lib']

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']
   # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "filter" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core-plugin-api", "~> 2.0"
  s.add_runtime_dependency "phonelib"
  s.add_development_dependency 'logstash-devutils'
end
