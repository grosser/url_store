require 'active_support'

class UrlStore
  VERSION = File.read( File.join(File.dirname(__FILE__),'..','VERSION') ).strip
  SECRET = 'asdkasjlwqjdqaccxnjkasdfh2313'
  METHOD = 'SHA1'

  # (convert to base64url <-> RFC4648) and '|'
  # which is not url-safe if you ask ERB/CGI, but browsers accept it
  IN = '+/='
  OUT = '-_|'

  cattr_accessor :secret
  self.secret = SECRET

  def self.encode(data)
    string = encoder.generate(data)
    string = string.sub('--', ';') # seperator of verifier
    string.to_s.tr(IN,OUT)
  end

  def self.decode(string)
    string = string.to_s.tr(OUT,IN) # convert to base64url <-> RFC4648
    string = string.sub(';','--') # seperator of verifier
    begin
      encoder.verify(string)
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      nil
    end
  end

  private

  def self.encoder
    ActiveSupport::MessageVerifier.new(secret, METHOD)
  end
end