require 'url_store/compact_encoder'

class UrlStore
  VERSION = File.read( File.join(File.dirname(__FILE__),'..','VERSION') ).strip
  SECRET = 'asdkasjlwqjdqaccxnjkasdfh2313'
  METHOD = 'SHA1'

  # (convert to base64url <-> RFC4648) and '|'
  # which is not url-safe if you ask ERB/CGI, but browsers accept it
  IN = '+/='
  OUT = '-_|'

  @@secret = SECRET
  def self.secret=(x); @@secret=x; end
  def self.secret; @@secret; end

  def self.encode(data)
    string = encoder.encode(data)
    string.to_s.tr(IN,OUT)
  end

  def self.decode(string)
    string = string.to_s.tr(OUT,IN) # convert to base64url <-> RFC4648
    encoder.decode(string)
  end

  private

  def self.encoder
    if secret == SECRET
      warn "WARNING: you should not use the default secret! use UrlStore.secret='something'"
    end
    UrlStore::CompactEncoder.new(secret, METHOD)
  end
end