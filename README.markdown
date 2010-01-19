Data securely stored in urls.

 - url-save output
 - short codes through GZip
 - serializing through __:marshal__ :yaml
 - hashing through DSS DSS1 MD2 MD4 MD5 MDC2 RIPEMD160 SHA __SHA1__ SHA224 SHA256 SHA384 SHA512


Install
=======
 - As gem: ` sudo gem install url_store `
 - As Rails plugin: ` script/plugin install git://github.com/grosser/url_store.git `

Usage
=====
    # config (e.g environment.rb)
    UrlStore.secret = 'adadasd2adsdasd4ads4eas4dea4dsea4sd'

    # View:
    <%= link_to 'paid', :controller=>:payments, :action=>:paid, :data=>UrlStore.encode(:id=>1, :status=>'paid') %>

    # Controller:
    if data = UrlStore.decode(params[:data])
      Payment.find(data[:id]).update_attribute(:status, data[:status])
    else
      raise 'FRAUD!'
    end

### Options
    UrlStore.secret = 'something random'
    UrlStore.hasher = 'MD5' # default: 'SHA1'
    UrlStore.serializer = :yaml # default: :marshal

Author
=======
[Michael Grosser](http://pragmatig.wordpress.com)  
grosser.michael@gmail.com  
Hereby placed under public domain, do what you want, just do not hold me accountable...