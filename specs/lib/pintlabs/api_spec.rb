require File.expand_path("lib/pintlabs")

describe Pintlabs::API do
  before do
    Pintlabs.configure do |config|
      config.api_key = "12345"
    end
  end

  context "Pintlabs::API::index" do
    it "should request the endpoint and validate the response" do
      HTTParty.should_receive(:get).with(Pintlabs.config.base_uri + "/beers", {"p" => 2, "api_key" => Pintlabs.config.api_key}).and_return({"status" => "success"})
      Pintlabs::API.index("/beers", {"p" => 2})
    end

    it "should raise an invalid response error when the request is unfulfilled" do
      HTTParty.should_receive(:get).and_return({"status" => "failure"})
      expect {Pintlabs::API.index("/beers", {"p" => 2})}.to raise_error(Pintlabs::UnsuccessfulRequestError)
    end
  end
end