require File.dirname(__FILE__) + '/spec_helper'
require 'cgi'

describe UrlStore do
  before do
    @secret = 'not the standart sssecrettt1231231áßðáïíœï©óïœ©áßïáöððííïö'
    UrlStore.defaults = {:secret  => @secret}
    @data = {:x => 11212, :y => 'asdasda sdasdasdASDJKSAJDLSKDLKDS', 'asdasd' => 12312312, 12.12 => 123123212312123, :asdasdasd => '2134 adasdasóáößðóöáåöäóðáœ©öóöfóöåäfóöéåfó'}
  end

  it "generates same code for same data" do
    UrlStore.encode(@data).should == UrlStore.encode(@data)
  end

  it "can decode / encode" do
    UrlStore.decode(UrlStore.encode(@data)).should == @data
  end

  it "cannot decode altered data" do
    encoded = UrlStore.encode(@data)
    UrlStore.decode(encoded+'x').should == nil
  end

  it "uses a lot of different chars" do
    UrlStore.encode(@data).split('').uniq.size.should >= 62
  end

  it "uses url-save characters" do
    encoded = UrlStore.encode(@data)
    CGI.escape(encoded).gsub('%3B',';').gsub('%7C','|').should == encoded
  end

  it "cannot decode with wrong secret" do
    encoded = UrlStore.encode(@data)
    UrlStore.defaults = {:secret => 'xxx'}
    UrlStore.decode(encoded).should == nil
  end

  it "warns when default secret is used" do
    UrlStore.defaults = {:secret => UrlStore::SECRET}
    $stderr.should_receive(:write).at_least(1)
    UrlStore.encode(1)
  end

  it "can compress" do
    x = 'a'*100
    UrlStore.encode(x).size.should <= x.size
  end

  it "can serialize using a different method" do
    old = UrlStore.encode(@data)
    UrlStore.defaults = {:serializer => :yaml, :secret => @secret}
    UrlStore.encode(@data).size.should_not == old.size
  end

  it "can serialize using different hasher" do
    old = UrlStore.encode(@data)
    UrlStore.defaults = {:hasher => 'MD5', :secret => @secret}
    UrlStore.encode(@data).size.should_not == old.size
  end

  it "has a VERSION" do
    UrlStore::VERSION.should =~ /^\d+\.\d+\.\d+$/
  end
end