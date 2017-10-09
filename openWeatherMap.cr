require "http/client"
require "json"

# A module containing classes and methods for interacting with the Open Weather
# Map API.

module OpenWeatherMap
  # A client for interfacing with the Open Weather Map API.
  class Client
    def initialize(key : String)
      @key = key
    end

    # Requests current weather information for a single city and returns it as
    # an instance of OpenWeatherMap::CurrentWeather.
    def getCurrentWeatherFor(city : String)
      response = HTTP::Client.get "http://api.openweathermap.org/data/2.5/weather?APPID=#{@key}&q=#{URI.escape(city)}"
      value = JSON.parse(response.body)
      CurrentWeather.new(value)
    end
  end

  # Contains all the information on the current weather status for any city.
  class CurrentWeather
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
end

key = "83658a490b36698e09e779d265859910"
city = "Mississauga"

weather = OpenWeatherMap::Client.new(key)
currentWeather = weather.getCurrentWeatherFor(city)
puts currentWeather.simpleOutput
