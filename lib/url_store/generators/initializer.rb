require 'rails/generators'

class UrlStore::InitializerGenerator < Rails::Generators::Base

  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end

  def create_initializer_file
    template 'initializer.erb', 'config/initializers/url_store.rb'
  end
end
