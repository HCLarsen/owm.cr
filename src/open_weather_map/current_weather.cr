require "./weather"
require "./coord"

# Contains all the information on the current weather status for any city.
class OpenWeatherMap::CurrentWeather < OpenWeatherMap::Weather
  include JSON::Serializable

  getter name : String
  getter id : Int32
  @[JSON::Field(key: "sys", root: "country")]
  getter country : String
  @coord : OpenWeatherMap::Coord

  # Returns the time passed since the instantiation of the object. Useful for
  # checking how recent the weather data is.
  def timePassed
    Time.now - @time
  end
end
