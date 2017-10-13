# Contains all the information on the current weather status for any city.
class OpenWeatherMap::CurrentWeather
  getter name : String
  getter id : Int32
  getter temp : Float64
  getter windSpeed : Float64
  getter description : String

  # Creates a new instance from the information in a JSON::Any object
  def initialize(value : JSON::Any)
    @name = value["name"].as_s
    @id = value["id"].as_i
    @temp = (value["main"]["temp"].as_f - 273.15).round(1)
    @description = value["weather"][0]["description"].as_s
    if value["wind"]["speed"].as_f?
      @windSpeed = value["wind"]["speed"].as_f
    else
      @windSpeed = value["wind"]["speed"].as_i.to_f
    end
  end

  # Outputs weather in a human readable format.
  def simpleOutput
    output = "Temperature in #{@name} is #{@temp} degrees, with #{@description}. "

    if @windSpeed > 5 && @temp < 10
      windChill = (13.12 + 0.6215 * @temp - 11.37 * @windSpeed ** 0.16 + 0.3965 * @temp * @windSpeed ** 0.16).round(1)
      output += "Wind Speed is #{@windSpeed * 3.6}k/h, with a windwchill of #{windChill} degrees."
    else
      output += "Wind is #{(@windSpeed * 3.6).round(1)}km/h."
    end

    output
  end
end
