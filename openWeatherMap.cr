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
params = { "id" => 6075357}
#params = { "lat" => 43.5, "lon" => -79.5}
#params = { "zip" => 94040}
currentWeather = weather.current_weather_for_city(params)
case currentWeather
when OpenWeatherMap::CurrentWeather
  puts currentWeather.simpleOutput
else
  puts currentWeather
end

#params = { "bbox" => [12.0,32.0,15.0,37.0,10] }
#params = { "lat" => 43.5, "lon" => -79.5, "cnt" => 3 }
#params = { "id" => [6075357, 6111708, 6092122] }
#currentWeather = weather.current_weather_for_cities(params)
#case currentWeather
#when Array(OpenWeatherMap::CurrentWeather)
#  currentWeather.each do |current|
#    puts "IDs: " + current.simpleOutput
#  end
#else
#  puts currentWeather
#end
