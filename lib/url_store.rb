require 'url_store/compact_encoder'

require 'url_store/railtie' if defined?(::Rails) && ::Rails::VERSION::MAJOR >= 3

class UrlStore
  VERSION = File.read( File.join(File.dirname(__FILE__),'..','VERSION') ).strip
  SECRET = 'asdkasjlwqjdqaccxnjkasdfh2313'

  # (convert to base64url <-> RFC4648) and '|'
  # which is not url-safe if you ask ERB/CGI, but browsers accept it
  IN = '+/='
  OUT = '-_|'

  @@defaults = {}
  def self.defaults=(x); @@defaults=x; end

  def self.encode(data)
    new.encode(data)
  end

  def self.decode(string)
    new.decode(string)
  end

  def initialize(options={})
    @options = @@defaults.merge(options)
  end

  def encode(data)
    string = encoder.encode(data)
    string.to_s.tr(IN,OUT)
  end

  def decode(string)
    string = string.to_s.tr(OUT,IN) # convert to base64url <-> RFC4648
    encoder.decode(string)
  end

  private

  def encoder
    options = {:secret => SECRET}.merge(@options)
    if options[:secret] == SECRET
      warn "WARNING: You are using the default secret! Set your own with UrlStore.defaults = {:secret => 'something'}"
    end
    UrlStore::CompactEncoder.new(options)
  end
end
