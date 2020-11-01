require_relative 'lib/prekladatelj/version'

Gem::Specification.new do |spec|
  spec.name          = "prekladatelj"
  spec.version       = Prekladatelj::VERSION
  spec.authors       = ["bikeroleg"]
  spec.email         = ["i4v.mail@yandex.com"]

  spec.summary       = %q{Convert Interslavic sentences from latin to cyrillic and vice versa}
  spec.description   = %q{This gem helps to convert a text from one writing system to another using Interslavic standards, with option to specify one. Also works as a standalone console program. }
  spec.homepage      = "https://github.com/bikeroleg/prekladatelj"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  #spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/bikeroleg/prekladatelj"
  #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.license       = "GPLv3"
end
