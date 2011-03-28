task :default do
  sh "rspec spec/"
end

begin
  require 'jeweler'
  project_name = 'url_store'
  Jeweler::Tasks.new do |gem|
    gem.name = project_name
    gem.description = gem.summary = "Data securely stored in urls."
    gem.email = "grosser.michael@gmail.com"
    gem.homepage = "http://github.com/grosser/#{project_name}"
    gem.authors = ["Michael Grosser"]
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install jeweler"
end
