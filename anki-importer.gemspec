# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "anki-importer"
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Victor Costan"]
  s.date = "2012-01-13"
  s.description = "Extracts models, facts and cards from Anki deck databases."
  s.email = "victor@costan.us"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".project",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "anki-importer.gemspec",
    "lib/anki/importer.rb",
    "lib/anki/importer/card_model.rb",
    "lib/anki/importer/deck.rb",
    "lib/anki/importer/fact.rb",
    "lib/anki/importer/field.rb",
    "lib/anki/importer/model.rb",
    "spec/anki_importer_spec.rb",
    "spec/fixtures/deck.anki",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/pwnall/anki_importer"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.15"
  s.summary = "Importer for Anki decks"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 3.1.0"])
      s.add_runtime_dependency(%q<i18n>, [">= 0.6.0"])
      s.add_runtime_dependency(%q<sqlite3>, [">= 1.3.5"])
      s.add_development_dependency(%q<rdoc>, [">= 3.9.4"])
      s.add_development_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.21"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, [">= 3.1.0"])
      s.add_dependency(%q<i18n>, [">= 0.6.0"])
      s.add_dependency(%q<sqlite3>, [">= 1.3.5"])
      s.add_dependency(%q<rdoc>, [">= 3.9.4"])
      s.add_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.21"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 3.1.0"])
    s.add_dependency(%q<i18n>, [">= 0.6.0"])
    s.add_dependency(%q<sqlite3>, [">= 1.3.5"])
    s.add_dependency(%q<rdoc>, [">= 3.9.4"])
    s.add_dependency(%q<rspec>, ["~> 2.8.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.21"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

