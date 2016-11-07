# -*- encoding: utf-8 -*-
# stub: as-duration 0.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "as-duration"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Janko Marohni\u{107}"]
  s.date = "2016-06-24"
  s.description = "Extraction of ActiveSupport::Duration and the related core extensions."
  s.email = ["janko.marohnic@gmail.com"]
  s.homepage = "https://github.com/janko-m/as-duration"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0")
  s.rubygems_version = "2.5.1"
  s.summary = "Extraction of ActiveSupport::Duration and the related core extensions."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<minitest>, ["= 5.6.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<minitest>, ["= 5.6.0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<minitest>, ["= 5.6.0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
