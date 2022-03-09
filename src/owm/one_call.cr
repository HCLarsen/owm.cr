require "json"

require "./converters"
require "./misc"

class OWM::OneCall
  abstract class Base
    include JSON::Serializable

    @[JSON::Field(key: "dt", converter: Time::EpochConverter)]
    getter time : Time
    getter pressure : Int32
    getter humidity : Int32
    @[JSON::Field(converter: Int32::NumberConverter)]
    getter dew_point : Int32
    getter wind_speed : Float64
    getter wind_deg : Int32
    getter wind_gust : Float64 = 0.0
    getter clouds : Int32
    getter uvi : Float64
    getter weather : Array(Weather)
  end

  class Current < Base
    @[JSON::Field(converter: Time::EpochConverter)]
    getter sunrise : Time
    @[JSON::Field(converter: Time::EpochConverter)]
    getter sunset : Time
    @[JSON::Field(converter: Int32::NumberConverter)]
    getter temp : Int32
    @[JSON::Field(converter: Int32::NumberConverter)]
    getter feels_like : Int32
    getter visibility : Int32
    getter rain : Precipitation = Precipitation.new
    getter snow : Precipitation = Precipitation.new
  end

  class Minutely
    include JSON::Serializable

    @[JSON::Field(key: "dt", converter: Time::EpochConverter)]
    getter time : Time
    getter precipitation : Float64
  end

  class Hourly < Base
    include JSON::Serializable

    @[JSON::Field(converter: Int32::NumberConverter)]
    getter temp : Int32
    @[JSON::Field(converter: Int32::NumberConverter)]
    getter feels_like : Int32
    getter visibility : Int32
    getter pop : Float64
    getter rain = Precipitation.new
    getter snow = Precipitation.new
  end

  class Daily < Base
    struct Temp
      include JSON::Serializable

      @[JSON::Field(converter: Int32::NumberConverter)]
      getter day : Int32
      @[JSON::Field(converter: Int32::NumberConverter)]
      getter min : Int32
      @[JSON::Field(converter: Int32::NumberConverter)]
      getter max : Int32
      @[JSON::Field(converter: Int32::NumberConverter)]
      getter night : Int32
      @[JSON::Field(converter: Int32::NumberConverter)]
      getter eve : Int32
      @[JSON::Field(converter: Int32::NumberConverter)]
      getter morn : Int32
    end

    struct FeelsLike
      include JSON::Serializable

      @[JSON::Field(converter: Int32::NumberConverter)]
      getter day : Int32
      @[JSON::Field(converter: Int32::NumberConverter)]
      getter night : Int32
      @[JSON::Field(converter: Int32::NumberConverter)]
      getter eve : Int32
      @[JSON::Field(converter: Int32::NumberConverter)]
      getter morn : Int32
    end

    @[JSON::Field(converter: Time::EpochConverter)]
    getter sunrise : Time
    @[JSON::Field(converter: Time::EpochConverter)]
    getter sunset : Time
    @[JSON::Field(converter: Time::EpochConverter)]
    getter moonrise : Time
    @[JSON::Field(converter: Time::EpochConverter)]
    getter moonset : Time
    getter moon_phase : Float64

    getter temp : Temp
    getter feels_like : FeelsLike
    getter pop : Float64

    getter rain : Float64 = 0.0
    getter snow : Float64 = 0.0
  end

  class Alert
    include JSON::Serializable

    getter sender_name : String
    getter event : String
    @[JSON::Field(key: "start", converter: Time::EpochConverter)]
    getter start_time : Time
    @[JSON::Field(key: "end", converter: Time::EpochConverter)]
    getter end_time : Time
    getter description : String
    getter tags : Array(String)
  end

  include JSON::Serializable

  getter lat : Float64
  getter lon : Float64
  getter timezone : String
  getter timezone_offset : Int32

  getter current : Current
  getter minutely : Array(Minutely)
  getter hourly : Array(Hourly)
  getter daily : Array(Daily)
  getter alerts : Array(Alert)
end
