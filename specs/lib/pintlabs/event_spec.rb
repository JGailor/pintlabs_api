require File.expand_path("lib/pintlabs")

describe Pintlabs::Event do
  let(:list_response_data) {
    {
      "status" => "success",
      "data" => [
        {
          "updateDate" => "",
          "id" => 1,
          "description" => "",
          "createDate" => "2011-11-11 09:21:06",
          "name" => "Light Lager",
          "bjcpCategory" => 1
        }
      ]
    }    
  }

  let(:single_response_data) {
    {
      "status" => "success",
      "data" => {
        "updateDate" => "",
        "id" => 1,
        "description" => "",
        "createDate" => "2011-11-11 09:21:06",
        "name" => "Light Lager",
        "bjcpCategory" => 1
      }
    }
  }

  before do
    Pintlabs.configure do |config|
      config.api_key = '12345'
    end
  end

  context "Pintlabs::Event.events" do
    it "should return a list of events" do
      Pintlabs::API.should_receive(:get).with("/events", {}).and_return(list_response_data)
      Pintlabs::Event.should_receive(:new).exactly(list_response_data["data"].size).times

      Pintlabs::Event.events
    end
  end

  context "Pintlabs::Event.event" do
    it "should fetch a single event based on an id" do
      Pintlabs::API.should_receive(:get).with("/events/1", {}).and_return(single_response_data)
      Pintlabs::Event.should_receive(:new).with(single_response_data["data"])

      Pintlabs::Event.event(1)
    end
  end

  context "Pintlabs::Event.new" do
    it "should generate a object representation of the API response" do
      event = Pintlabs::Event.new(single_response_data["data"])

      single_response_data["data"].each do |key, val|
        if val.kind_of?(Enumerable)
          val.each do |sub_key, sub_val|
            event.send(key.to_sym).send(sub_key.to_sym).should == sub_val
          end
        else
          event.send(key.to_sym).should == val
        end
      end
    end
  end
end