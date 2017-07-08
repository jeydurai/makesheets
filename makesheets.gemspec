# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'makesheets/version'

Gem::Specification.new do |spec|
  spec.name          = "makesheets"
  spec.version       = Makesheets::VERSION
  spec.authors       = ["Jeyaraj"]
  spec.email         = ["jeyaraj.durairaj@gmail.com"]

  spec.summary       = %q{Makes sheets based on Excel Column Data.}
  spec.description   = %q{Based on unique value of a column, it creates sheets.}
  spec.homepage      = "https://github.com/jeydurai"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.files << "lib/makesheets.rb"
  spec.files << "lib/makesheets/processor.rb"
  spec.files << "lib/makesheets/reader.rb"
  spec.files << "lib/makesheets/writer.rb"
  spec.files << "lib/makesheets/validator.rb"
  spec.files << "lib/makesheets/exceptions/validate.rb"
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.executables << 'makesheets' 
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "roo", "~> 2.7", ">= 2.7.1"
  spec.add_development_dependency "rubyXL", "~> 3.3", ">= 3.3.26"
end
