# Contains all the information on the current weather status for any city.
class OpenWeatherMap::CurrentWeather
  getter time : Time
  getter name : String
  getter id : Int32

  getter weather_id : Int32
  getter weather_main : String
  getter weather_description : String
  getter weather_icon : String

  getter temp : Float64
  getter pressure : Float64
  getter humidity : Int32
  getter windSpeed : Float64
  getter windDirection : Int32
  getter clouds : Int32
  getter rain : Int32
  getter snow : Int32

  # Creates a new instance of CurrentWeather from the information in a JSON::Any object
  def initialize(value : JSON::Any)
    @time = Time.now
    @name = value["name"].as_s
    @id = value["id"].as_i

    @weather_id = value["weather"][0]["id"].as_i
    @weather_main = value["weather"][0]["main"].as_s
    @weather_description = value["weather"][0]["description"].as_s
    @weather_icon = value["weather"][0]["icon"].as_s

    @temp = ((value["main"]["temp"].as_f? || value["main"]["temp"].as_i.to_f) - 273.15).round(1)
    @pressure = (value["main"]["pressure"].as_f? || value["main"]["pressure"].as_i.to_f)
    @humidity = value["main"]["humidity"].as_i
    @windSpeed = (value["wind"]["speed"].as_f? || value["wind"]["speed"].as_i.to_f)
    @windDirection = (value["wind"]["speed"].as_i? || value["wind"]["speed"].as_f.to_i)
    @clouds = value["clouds"]["all"].as_i
    @rain = (value["rain"]?.try(&.as_h) || { String => Hash })["3h"]?.try(&.to_s.to_i) || 0
    @snow = (value["snow"]?.try(&.as_h) || { String => Hash })["3h"]?.try(&.to_s.to_i) || 0
  end

  # Returns the time passed since the instantiation of the object. Useful for
  # checking how recent the weather data is.
  def timePassed
    Time.now - @time
  end

  # Outputs weather in a human readable format.
  def simpleOutput
    output = "Temperature in #{@name} is #{@temp} degrees, with #{@weather_description}. "

    if @windSpeed > 5 && @temp < 10
      windChill = (13.12 + 0.6215 * @temp - 11.37 * @windSpeed ** 0.16 + 0.3965 * @temp * @windSpeed ** 0.16).round(1)
      output += "Wind Speed is #{(@windSpeed * 3.6).round(1)}k/h, with a windchill of #{windChill} degrees."
    else
      output += "Wind Speed is #{(@windSpeed * 3.6).round(1)}km/h."
    end

    output
  end
end
