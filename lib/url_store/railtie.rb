class UrlStore::Railtie < ::Rails::Railtie
  
  generators do
    require 'url_store/generators/initializer'
  end
end
