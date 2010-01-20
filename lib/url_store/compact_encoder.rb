require 'base64'
require 'zlib'

class UrlStore
  class CompactEncoder
    def initialize(options={})
      @secret = options[:secret] || raise('i need a :secret !!')
      @hasher = options[:hasher] || 'SHA1'
      @serializer = options[:serializer] || :marshal
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
      case @serializer.to_sym
      when :yaml then data.to_yaml
      when :marshal then Marshal.dump(data)  
      end
    end

    def deserialize(data)
      case @serializer.to_sym
      when :yaml then YAML.load(data)
      when :marshal then Marshal.load(data)
      end
    end

    def compress(data)
      Base64.encode64( Zlib::Deflate.deflate(data)).gsub("\n",'')
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
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new(@hasher.to_s), @secret, data)
    end
  end
end