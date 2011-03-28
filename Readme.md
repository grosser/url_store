Data securely stored in urls.

 - url-save output
 - short codes through GZip
 - serializing through __:marshal__ :yaml
 - hashing through DSS DSS1 MD2 MD4 MD5 MDC2 RIPEMD160 SHA __SHA1__ SHA224 SHA256 SHA384 SHA512

Great for:

 - password reset links
 - email unsubscribe links
 - click tracking
 - access control
 - ...


Install
=======
 - As gem: ` sudo gem install url_store `
 - As Rails plugin: ` rails plugin install git://github.com/grosser/url_store.git `

Usage
=====
    # config (e.g environment.rb)
    UrlStore.defaults = {:secret => 'adadasd2adsdasd4ads4eas4dea4dsea4sd'}

    # View:
    <%= link_to 'paid', :controller=>:payments, :action=>:paid, :data=>UrlStore.encode(:id=>1, :status=>'paid') %>

    # Controller:
    if data = UrlStore.decode(params[:data])
      Payment.find(data[:id]).update_attribute(:status, data[:status])
    else
      raise 'FRAUD!'
    end

### Defaults
    UrlStore.defaults = {:secret => 'something random'} # ALWAYS use your own secret
    UrlStore.defaults = {... , :hasher => 'MD5'} # default: 'SHA1'
    UrlStore.defaults = {... , :serializer => :yaml} # default: :marshal

### Tips
 - If you need multiple UrlStores, just use ` UrlStore.new(:secret => 'sadasd', ...) `
 - As long as you stay under 2k chars there should be no problems. [max url lengths per browser/server](http://www.boutell.com/newfaq/misc/urllength.html)
 - Data is not (yet) encrypted, users could read(but not change) the encoded data
 - Replay attacks are possible <-> add a timestamp to check the freshness of the encoded data

Author
=======
[Michael Grosser](http://grosser.it)<br/>
michael@grosser.it<br/>
Hereby placed under public domain, do what you want, just do not hold me accountable...
