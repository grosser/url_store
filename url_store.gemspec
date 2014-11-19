name = "url_store"
require "./lib/#{name}/version"

Gem::Specification.new name, UrlStore::VERSION do |s|
  s.summary = "Data securely stored in urls."
  s.authors = ["Michael Grosser"]
  s.email = "michael@grosser.it"
  s.homepage = "https://github.com/grosser/#{name}"
  s.files = `git ls-files lib`.split("\n")
  s.license = "MIT"
end
