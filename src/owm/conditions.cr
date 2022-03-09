require "json"

require "./converters"
require "./misc"

# Contains all the information on the current weather status for any city.
class OWM::Conditions
  include JSON::Serializable

  @[JSON::Field(key: "dt", converter: Time::EpochConverter)]
  getter time : Time
  getter main : Main
  getter wind : Wind
  getter weather : Array(Weather)
  @[JSON::Field(root: "all")]
  getter clouds : Int32 = 0
  getter rain : Precipitation = Precipitation.new
  getter snow : Precipitation = Precipitation.new

  # Structs for mapping the json subobjects within returned data.
  struct Main
    include JSON::Serializable

    getter temp : Float64
    @[JSON::Field(converter: Int32::NumberConverter)]
    getter pressure : Int32
    getter humidity : Int32
    getter temp_min : Float64
    getter temp_max : Float64
    @[JSON::Field(converter: Int32::NumberConverter)]
    @grnd_level : Int32?
    @[JSON::Field(converter: Int32::NumberConverter)]
    @sea_level : Int32?

    # Custom Getters
    def sea_level : Int32
      @sea_level || pressure
    end

    def grnd_level : Int32
      @grnd_level || pressure
    end
  end

  struct Wind
    include JSON::Serializable

    @[JSON::Field(converter: Int32::NumberConverter)]
    getter speed : Int32

    @[JSON::Field(converter: Int32::NumberConverter)]
    getter deg : Int32

    @[JSON::Field(converter: Int32::NumberConverter)]
    getter gust : Int32 = 0
  end
end
