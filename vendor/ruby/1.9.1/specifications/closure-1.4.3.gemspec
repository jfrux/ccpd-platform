# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "closure"
  s.version = "1.4.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Turnbull"]
  s.date = "2011-12-01"
  s.email = ["dturnbull@gmail.com"]
  s.executables = ["closure-script"]
  s.files = ["bin/closure-script"]
  s.homepage = "https://github.com/dturnbull/closure-script"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "Google Closure Compiler, Library, Script, and Templates."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 1.0.0"])
    else
      s.add_dependency(%q<rack>, [">= 1.0.0"])
    end
  else
    s.add_dependency(%q<rack>, [">= 1.0.0"])
  end
end
