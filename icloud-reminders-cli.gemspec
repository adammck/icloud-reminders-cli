#!/usr/bin/env ruby
# vim: et ts=2 sw=2

Gem::Specification.new do |gem|
  gem.name          = "icloud-reminders-cli"
  gem.version       = "0.1"

  gem.authors       = ["Adam Mckaig"]
  gem.email         = ["adam.mckaig@gmail.com"]
  gem.summary       = %q{Command-line tool for managing iCloud reminders}
  gem.homepage      = "https://github.com/adammck/icloud-reminders-cli"

  gem.add_dependency "trollop"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
