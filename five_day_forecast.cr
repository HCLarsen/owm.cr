require "./weather"

# Contains all the information on the current weather status for any city.
class OpenWeatherMap::FiveDayForecast
  getter time : Time
  getter name : String
  getter id : Int32
  getter list : Array(Weather)

  # Creates a new instance of CurrentWeather from the information in a JSON::Any object
  def initialize(value : JSON::Any)
    @time = Time.now
    @name = value["city"]["name"].as_s
    @id = value["city"]["id"].as_i
    @list = [] of Weather

    forecast = value["list"]
    @list = forecast.map do |e|
      Weather.new(e)
    end
  end

  # Returns the time passed since the instantiation of the object. Useful for
  # checking how recent the weather data is.
  def timePassed
    Time.now - @time
  end

  def simple_output
    output = "5 day/3 hour forecast for #{@name}: "
    @list.each do |e|
      output += "\n#{e.temp} at #{e.time.to_s("%a %b %-d %H:%M")}"
      output += " with #{e.snow}mm of snow expected." if e.snow > 0
      output += " with #{e.rain}mm of snow expected." if e.rain > 0
    end
    output
  end
end
