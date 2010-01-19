require 'base64'
require 'zlib'

class UrlStore
  class CompactEncoder
    def initialize(secret, algorithm)
      @secret = secret; @algorithm = algorithm
    end

    def encode(data)
      data = compress(serialize(data))
      data+digest(data)
    end

    def decode(data)
      hash = data[-hash_length..-1]
      data = data[0...-hash_length]

      if digest(data) == hash
        deserialize extract(data)
      else
        nil
      end
    end

    private

    def serialize(data)
      Marshal.dump data
    end

    def deserialize(data)
      Marshal.load data
    end

    def compress(data)
      Base64.encode64( Zlib::Deflate.deflate data ).gsub("\n",'')
    end

    def extract(data)
      Zlib::Inflate.inflate Base64.decode64(data)
    end

    def hash_length
      digest('x').size
    end

    # stolen from ActiveSupport
    def digest(data)
      require 'openssl' unless defined?(OpenSSL)
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new(@algorithm), @secret, data)
    end
  end
end