require 'active_support'

class UrlStore
  SECRET = 'asdkasjlwqjdqaccxnjkasdfh2313'
  METHOD = 'SHA1'
#  IN = '+/='
#  OUT = '-_|' # | is not url-safe if you ask ERB/CGI, but browsers accept it, (. is no good idea <-> could be misread as format)
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
    string = string.sub(';','--')
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