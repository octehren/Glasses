$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "glasses/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name          = "glasses"
  spec.version       = Glasses::VERSION
  spec.authors       = ["Otávio Monteagudo"]
  spec.email         = ["oivatom@gmail.com"]
  spec.summary       = %q{ Simplify searches on Ruby web frameworks which utilize ActiveRecord as a DB interface. }
  spec.description   = %q{ Running through ActiveRecord's relations, this gem makes it very simple to quickly search through a given model's columns and return an array of objects that match the searched criteria.
                           See the README available in the 'Documentation' repository found in the link below.}
  spec.homepage      = "https://github.com/otamm/Glasses"
  spec.license       = "MIT"
  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  #spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.test_files    = Dir["spec/**/*"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "rails", "~> 4.2.1"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "database_cleaner"
  spec.add_development_dependency "capybara"
  spec.add_dependency "rake", "~> 10.0"
  spec.add_dependency "activerecord", ">= 3.0.18" #must have .where() method
end
