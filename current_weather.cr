require "./weather"

# Contains all the information on the current weather status for any city.
class OpenWeatherMap::CurrentWeather < OpenWeatherMap::Weather
  #getter time : Time
  getter name : String
  getter id : Int32

  # Creates a new instance of CurrentWeather from the information in a JSON::Any object
  def initialize(value : JSON::Any)
    super

    #@time = Time.now
    @name = value["name"].as_s
    @id = value["id"].as_i
  end

  # Returns the time passed since the instantiation of the object. Useful for
  # checking how recent the weather data is.
  def timePassed
    Time.now - @time
  end

  # Outputs weather in a human readable format.
  def simpleOutput
    output = "Temperature in #{@name} at #{@time} is #{@temp} degrees, with #{@weather_description}. "

    if @windSpeed > 5 && @temp < 10
      windChill = (13.12 + 0.6215 * @temp - 11.37 * @windSpeed ** 0.16 + 0.3965 * @temp * @windSpeed ** 0.16).round(1)
      output += "Wind Speed is #{(@windSpeed * 3.6).round(1)}k/h, with a windchill of #{windChill} degrees."
    else
      output += "Wind Speed is #{(@windSpeed * 3.6).round(1)}km/h."
    end

    output
  end
end
