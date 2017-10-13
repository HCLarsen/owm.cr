require "http/client"
require "json"

require "./current_weather"

# A client for interfacing with the Open Weather Map API.
class OpenWeatherMap::Client
  def initialize(key : String)
    @key = key
  end

  # Requests current weather information for a single city by city ID and returns it as
  # an instance of OpenWeatherMap::CurrentWeather.
  def getCurrentWeatherFor(cityID : Int32)
    response = HTTP::Client.get "http://api.openweathermap.org/data/2.5/weather?APPID=#{@key}&id=#{cityID}"
    # Need code to check the response type before parsing.
    value = JSON.parse(response.body)
    CurrentWeather.new(value)
  end
  # Requests current weather information for a single city by name and returns it as
  # an instance of OpenWeatherMap::CurrentWeather.
  def getCurrentWeatherFor(city : String)
    response = HTTP::Client.get "http://api.openweathermap.org/data/2.5/weather?APPID=#{@key}&q=#{URI.escape(city)}"
    value = JSON.parse(response.body)
    CurrentWeather.new(value)
  end
end
