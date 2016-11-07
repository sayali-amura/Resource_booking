# -*- encoding: utf-8 -*-
# stub: intl-tel-input-rails 8.4.9 ruby lib

Gem::Specification.new do |s|
  s.name = "intl-tel-input-rails"
  s.version = "8.4.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Ilias Spyropoulos"]
  s.date = "2016-04-18"
  s.description = "    A jQuery plugin for entering and validating international telephone numbers.\n    This gem allows for its easy inclusion into the Rails asset pipeline.\n"
  s.email = ["ilias@testributor.com"]
  s.homepage = "https://github.com/ispyropoulos/intl-tel-input-rails"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "intl-tel-input for the Rails asset pipeline."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, [">= 3.1"])
      s.add_runtime_dependency(%q<sass-rails>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.5"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<railties>, [">= 3.1"])
      s.add_dependency(%q<sass-rails>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.5"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<railties>, [">= 3.1"])
    s.add_dependency(%q<sass-rails>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.5"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
