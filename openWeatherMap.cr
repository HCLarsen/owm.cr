require "http/client"
require "json"

require "./client"

# A module containing classes and methods for interacting with the Open Weather
# Map API.
module OpenWeatherMap
end

key = ENV["OWM"]

weather = OpenWeatherMap::Client.new(key)

#params = { "city" => "Mississauga" }
#params = { "id" => 1851632}
#params = { "lat" => 43.5, "lon" => -79.5}
#params = { "zip" => 94040}
#currentWeather = weather.current_weather_for_city(params)
#case currentWeather
#when OpenWeatherMap::CurrentWeather
#  puts currentWeather.simple_output
#else
#  puts currentWeather
#end

params = { "lat" => 43.5, "lon" => -79.5}
suntimes = weather.sunrise_sunset_for_city(params)
case suntimes
when Array(Time)
  puts "Sunrise: #{suntimes.first.to_s("%H:%M")}, sunset: #{suntimes.last.to_s("%H:%M")}"
else
  puts suntimes
end

#params = { "bbox" => [12.0,32.0,15.0,37.0,10] }
#params = { "lat" => 43.5, "lon" => -79.5, "cnt" => 10 }
#params = { "id" => [6075357, 6111708, 6092122, 1851632] }
#currentWeather = weather.current_weather_for_cities(params)
#case currentWeather
#when Array(OpenWeatherMap::CurrentWeather)
#  currentWeather.each do |current|
#    puts "IDs: " + current.simple_output
#  end
#else
#  puts currentWeather
#end

params = { "lat" => 43.5, "lon" => -79.5}
forecast = weather.five_day_forecast_for_city(params)
case forecast
when OpenWeatherMap::FiveDayForecast
  puts forecast.simple_output
else
  puts forecast
end
