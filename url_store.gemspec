$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
name = "url_store"
require "#{name}/version"

Gem::Specification.new name, UrlStore::VERSION do |s|
  s.summary = "Data securely stored in urls."
  s.authors = ["Michael Grosser"]
  s.email = "michael@grosser.it"
  s.homepage = "http://github.com/grosser/#{name}"
  s.files = `git ls-files`.split("\n")
  s.license = "MIT"
end
