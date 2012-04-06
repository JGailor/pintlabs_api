require File.expand_path("lib/pintlabs")

describe Pintlabs::Brewery do
  let(:list_response_data) {
    {
      "status" => "success",
      "numberOfPages" => 63,
      "data" => [
        {
          "id" => "KlSsWY",
          "description" => "",
          "name" => "'t Hofbrouwerijke",
          "createDate" => "2012-01-02 11:50:52",
          "mailingListUrl" => "",
          "updateDate" => "",
          "images" => {
            "medium" => "",
            "large" => "",
            "icon" => ""
          },
          "established" => "",
          "isOrganic" => "N",
          "website" => "http://www.thofbrouwerijke.be/",
          "status" => "verified",
          "statusDisplay" => "Verified"
        }
      ],
      "currentPage" => 1
    }    
  }

  let(:single_response_data) {
    {
      "status" => "success",
      "data" => {
        "id" => "KR4X6i",
        "description" => "The fact that D.C. has become a world-class beer town ...",
        "name" => "DC Brau Brewing",
        "createDate" => "2012-01-02 00:00:21",
        "mailingListUrl" => "",
        "updateDate" => "2012-01-02 20:12:39",
        "images" => {
          "medium" => "http://s3.amazonaws.com/brewerydbapi-playground/brewery/KR4X6i/upload_J9oZ2o-medium.png",
          "large" => "http://s3.amazonaws.com/brewerydbapi-playground/brewery/KR4X6i/upload_J9oZ2o-large.png",
          "icon" => "http://s3.amazonaws.com/brewerydbapi-playground/brewery/KR4X6i/upload_J9oZ2o-icon.png"
        },
        "established" => "2009",
        "isOrganic" => "N",
        "website" => "http://www.dcbrau.com",
        "status" => "verified",
        "statusDisplay" => "Verified"
      },
      "message" => "Request Successful"
    }    
  }

  before do
    Pintlabs.configure do |config|
      config.api_key = '123456'
    end
  end

  context "Pintlabs::Brewery::breweries" do
    it "should fetch the list of breweries" do
      Pintlabs::API.should_receive(:get).with("/breweries", {}).and_return(list_response_data)

      breweries = Pintlabs::Brewery.breweries({})
      breweries.size.should == list_response_data["data"].size
    end
  end

  context "Pintlabs::Brewery::brewery" do
    it "should fetch a single brewery" do
      Pintlabs::API.should_receive(:get).with("/brewery/1", {}).and_return(single_response_data)
      Pintlabs::Brewery.should_receive(:new).with(single_response_data["data"])

      Pintlabs::Brewery.brewery(1)
    end
  end

  context "Pintlabs::Brewery.new" do
    it "should correctly unwrap the attributes" do
      brewery = Pintlabs::Brewery.new(single_response_data["data"])

      single_response_data["data"].each do |key, val|
        if val.kind_of?(Enumerable)
          val.each do |sub_key, sub_val|
            brewery.send(key.to_sym).send(sub_key.to_sym).should == sub_val
          end
        else
          brewery.send(key.to_sym).should == val
        end
      end
    end
  end
end