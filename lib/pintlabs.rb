require 'ostruct'
require 'pintlabs/api'
require 'pintlabs/labels'
require 'pintlabs/style'
require 'pintlabs/availability'
require 'pintlabs/glass'
require 'pintlabs/beer'
require 'pintlabs/images'
require 'pintlabs/brewery'
require 'pintlabs/event'
require 'httparty'

module Pintlabs
  class UnsuccessfulRequestError < Exception
  end

  def self.configure(&block)
    @@config = OpenStruct.new({"base_uri" => "http://api.brewerydb.com/v2"})
    yield @@config
  end

  def self.config
    @@config
  end
end