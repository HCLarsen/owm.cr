require "http/client"
require "json"

require "./client"

# A module containing classes and methods for interacting with the Open Weather
# Map API.
module OpenWeatherMap
end

key = ENV["OWM"]
city = "Mississauga"
cityID = 6075357
lat = 43.5
long = -79.5
zip = 94040

weather = OpenWeatherMap::Client.new(key)

currentWeather = weather.currentWeatherForCity(cityID)
case currentWeather
when OpenWeatherMap::CurrentWeather
  puts "City ID: " + currentWeather.simpleOutput
else
  puts currentWeather
end

#currentWeather = weather.currentWeatherForCities(lat, long, 10)
#currentWeather = weather.currentWeatherForCities(12.0,32.0,15.0,37.0,10)
currentWeather = weather.currentWeatherForCities([6075357,6111708,6092122])
case currentWeather
when Array(OpenWeatherMap::CurrentWeather)
  currentWeather.each do |current|
    puts "IDs: " + current.simpleOutput
  end
else
  puts currentWeather
end
