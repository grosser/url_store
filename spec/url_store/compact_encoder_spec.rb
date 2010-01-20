require File.dirname(__FILE__) + '/../spec_helper'

describe UrlStore::CompactEncoder do
  before do
    @encoder = UrlStore::CompactEncoder.new(:secret => 'asdasdsa')
    @data = {:x => 1, 'asdadadadas' => 'asdasdadawvxcxcxcvjs', 'dasdasdadsadad' => 'asdasdwxczvvcjjkdfjkdf'}
  end

  it "generates same code for same data" do
    @encoder.encode(@data).should == @encoder.encode(@data)
  end

  it "can decode / encode" do
    @encoder.decode(@encoder.encode(@data)).should == @data
  end

  it "generates shorter codes than pure base64" do
    hash_length = 40
    @encoder.encode(@data).size.should < (Base64.encode64(Marshal.dump(@data)).size + hash_length)
  end

  it "can encode/decode with yaml" do
    @encoder = UrlStore::CompactEncoder.new(:secret => 'asdasdsa', :serializer => :yaml)
    @encoder.decode(@encoder.encode(@data)).should == @data
  end

  it "can hash with other hasher" do
    @encoder = UrlStore::CompactEncoder.new(:secret => 'asdasdsa', :hasher => 'MD5')
    @encoder.decode(@encoder.encode(@data)).should == @data
  end
end
