# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "sprite-factory"
  s.version = "1.5.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jake Gordon"]
  s.date = "2013-02-21"
  s.description = "Combines individual images from a directory into a single sprite image file and creates an appropriate CSS stylesheet"
  s.email = ["jake@codeincomplete.com"]
  s.executables = ["sf"]
  s.extra_rdoc_files = ["README.md"]
  s.files = ["bin/sf", "README.md"]
  s.homepage = "https://github.com/jakesgordon/sprite-factory"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "Automatic CSS sprite generator"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rmagick>, [">= 0"])
      s.add_development_dependency(%q<chunky_png>, [">= 0"])
    else
      s.add_dependency(%q<rmagick>, [">= 0"])
      s.add_dependency(%q<chunky_png>, [">= 0"])
    end
  else
    s.add_dependency(%q<rmagick>, [">= 0"])
    s.add_dependency(%q<chunky_png>, [">= 0"])
  end
end
