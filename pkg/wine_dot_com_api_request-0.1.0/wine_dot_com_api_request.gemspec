# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{wine_dot_com_api_request}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Christopher Meiklejohn"]
  s.date = %q{2010-01-02}
  s.description = %q{Provides an interface to the wine.com API.}
  s.email = %q{cmeik@me.com}
  s.extra_rdoc_files = ["README.rdoc", "lib/wine_dot_com_api_request.rb", "lib/wine_dot_com_api_request/configuration.rb"]
  s.files = ["MIT-LICENSE", "Manifest", "README.rdoc", "Rakefile", "init.rb", "lib/wine_dot_com_api_request.rb", "lib/wine_dot_com_api_request/configuration.rb", "test/wine_dot_com_api_request_test.rb", "wine_dot_com_api_request.gemspec"]
  s.homepage = %q{https://github.com/cmeiklejohn/wine_dot_com_api_request}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Wine_dot_com_api_request", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{wine_dot_com_api_request}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Provides an interface to the wine.com API.}
  s.test_files = ["test/wine_dot_com_api_request_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
