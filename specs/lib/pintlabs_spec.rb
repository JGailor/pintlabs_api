require File.expand_path("lib/pintlabs")

describe Pintlabs do
  let(:api_key) {'123456789'}
  it "should be configured with an API key" do
    Pintlabs.configure do |config|
      config.api_key = api_key
    end

    Pintlabs.config.api_key.should == api_key
  end
end