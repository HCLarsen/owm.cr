require "./weather"

# Contains all the information on the current weather status for any city.
class OpenWeatherMap::CurrentWeather < OpenWeatherMap::Weather
  include JSON::Serializable

  getter name : String
  getter id : Int32
  @[JSON::Field(key: "sys", root: "country")]
  getter country : String
  @[JSON::Field(key: "dt", converter: Time::EpochConverter)]
  getter time : Time
  @coord : Coord
  @main : Main
  @wind : Wind
  @[JSON::Field(key: "weather")]
  getter conditions : Array(Conditions)
  @[JSON::Field(root: "all")]
  getter clouds : Int32 = 0
  @rain : Rain = OpenWeatherMap::Weather::Rain.new
  @snow : Snow = OpenWeatherMap::Weather::Snow.new

  struct Coord
    include JSON::Serializable

    getter lon : Float64
    getter lat : Float64
  end

  # Returns the time passed since the instantiation of the object. Useful for
  # checking how recent the weather data is.
  def timePassed
    Time.now - @time
  end

  def rain
    @rain.rain
  end

  def snow
    @snow.snow
  end
end
