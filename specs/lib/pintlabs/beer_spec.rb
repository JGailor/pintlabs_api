require File.expand_path("lib/pintlabs")
require File.expand_path("lib/pintlabs/beer")

describe Pintlabs::Beer do
  let(:response_data) {
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

  context "Pintlabs::Beer::index" do
    before do
      Pintlabs.configure do |config|
        config.api_key = '12345'
      end
    end

    it "should return a list of Beer objects when the API is successfully queried" do
      Pintlabs::API.should_receive(:index).with("/beers", {}).and_return(response_data)

      beers = Pintlabs::Beer.index({})
      beers.size.should == response_data["data"].size
    end
  end

  context "Pintlabs#new" do
    it "should initialize the whole Beer object graph" do
      beer = Pintlabs::Beer.new(response_data["data"].first)
      beer.servingTemperatureDisplay.should == response_data["data"].first["servingTemperatureDisplay"]
      beer.labels.should be_instance_of(Pintlabs::Labels)
      beer.style.should be_instance_of(Pintlabs::Style)
      beer.available.should be_instance_of(Pintlabs::Availability)
      beer.glass.should be_instance_of(Pintlabs::Glass)
    end
  end
end