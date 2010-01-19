require File.dirname(__FILE__) + '/spec_helper'
require 'cgi'

describe UrlStore do
  before do
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
    UrlStore.encode(@data).split('').uniq.size.should >= 63
  end

  it "uses url-save characters" do
    encoded = UrlStore.encode(@data)
    CGI.escape(encoded).gsub('%3B',';').gsub('%7C','|').should == encoded
  end

  it "cannot decode with wrong secret" do
    encoded = UrlStore.encode(@data)
    UrlStore.secret = 'xxx'
    UrlStore.decode(encoded).should == nil
  end
end