# encoding: utf-8
require File.expand_path("lib/pintlabs")

describe Pintlabs::Beer do
  let(:list_response_data) {
    {
      "status" =>  "success", 
      "data" => [
        {
          "servingTemperatureDisplay" => "98",
          "labels" => {
            "medium" => "",
            "large" => "",
            "icon" => ""
          },
          "style" => {
            "id" => 1,
            "category" => {
              "updateDate" => "",
              "id" => 1
            }
          },
          "available" => {
            "description" => "Damn good beer",
            "name" => "Year Round"
          },
          "glass" => {
            "updateDate" => "",
            "id" => 10,
            "description" => "",
            "name" => "Pint"
          }
        }
      ]
    }
  }

  let(:single_response_data) {
    {
      "status" => "success",
      "data" => {
        "servingTemperatureDisplay" => "Cool - (8-12C/45-54F)",
        "labels" => {
          "medium" => "http://s3.amazonaws.com/brewerydbapi-playground/beer/O3tmVI/upload_eYWSl6-medium.png",
          "large" => "http://s3.amazonaws.com/brewerydbapi-playground/beer/O3tmVI/upload_eYWSl6-large.png",
          "icon" => "http://s3.amazonaws.com/brewerydbapi-playground/beer/O3tmVI/upload_eYWSl6-icon.png"
        },
        "style" => {
          "id" => 33,
          "category" => {
            "updateDate" => "",
            "id" => 10,
            "description" => "",
            "createDate" => "2012-01-02 00:00:06",
            "name" => "American Ale",
            "bjcpCategory" => "10"
          },
          "description" => "",
          "ibuMax" => "45",
          "simpleUrl" => "american-pale-ale",
          "srmMin" => "5",
          "srmMax" => "14",
          "ibuMin" => "30",
          "bjcpSubcategory" => "A",
          "ogMax" => "1.06",
          "fgMin" => "1.01",
          "fgMax" => "1.015",
          "createDate" => "2012-01-02 00:00:06",
          "updateDate" => "",
          "abvMax" => "6.2",
          "ogMin" => "1.045",
          "abvMin" => "4.5",
          "name" => "American Pale Ale",
          "categoryId" => 10
        },
        "status" => "verified",
        "srmId" => "",
        "beerVariationId" => "",
        "statusDisplay" => "Verified",
        "foodPairings" => "",
        "srm" => [],
        "updateDate" => "2012-01-02 17:10:00",
        "servingTemperature" => "cool",
        "availableId" => 1,
        "beerVariation" => [],
        "abv" => "6",
        "year" => "",
        "name" => "The Public",
        "id" => "O3tmVI",
        "originalGravity" => "",
        "styleId" => 33,
        "ibu" => "",
        "glasswareId" => 8,
        "isOrganic" => "N",
        "createDate" => "2012-01-02 00:02:15",
        "available" => {
          "description" => "Available year round as a staple beer.",
          "name" => "Year Round"
        },
        "glass" => {
          "updateDate" => "",
          "id" => 8,
          "description" => "",
          "createDate" => "2012-01-02 00:00:06",
          "name" => "Tulip"
        },
        "description" => "The Public™ is a delicious easy drinking pale ale made..."
      },
      "message" => "Request Successful"
    }    
  }

  context "finder methods" do
    before do
      Pintlabs.configure do |config|
        config.api_key = '12345'
      end
    end

    context "Pintlabs::Beer::beers" do
      it "should return a list of Beer objects when the API is successfully queried" do
        Pintlabs::API.should_receive(:get).with("/beers", {}).and_return(list_response_data)

        beers = Pintlabs::Beer.beers({})
        beers.size.should == list_response_data["data"].size
      end
    end

    context "Pintlabs::Beer::beer" do
      it "should return a beer based on an id" do
        Pintlabs::API.should_receive(:get).with("/beer/1", {}).and_return(single_response_data)
        Pintlabs::Beer.should_receive(:new).with(single_response_data["data"])
        beer = Pintlabs::Beer.beer(1)
      end
    end
  end

  context "Pintlabs#new" do
    it "should initialize the whole Beer object graph" do
      beer = Pintlabs::Beer.new(single_response_data["data"])
      beer.servingTemperatureDisplay.should == single_response_data["data"]["servingTemperatureDisplay"]
      beer.labels.should be_instance_of(Pintlabs::Labels)
      beer.style.should be_instance_of(Pintlabs::Style)
      beer.available.should be_instance_of(Pintlabs::Availability)
      beer.glass.should be_instance_of(Pintlabs::Glass)
    end
  end
end