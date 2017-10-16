require "http/client"
require "json"

require "./client"

# A module containing classes and methods for interacting with the Open Weather
# Map API.
module HTTP
end

key = ENV["OWM"]
city = "Mississauga"
cityID = 6075357
lat = 43.5
long = -79.5
zip = 94040

params = { "id" => "6075357" }

weather = OpenWeatherMap::Client.new(key)
currentWeather = weather.getCurrentWeatherFor(params)
case currentWeather
when OpenWeatherMap::CurrentWeather
  puts "Hash: " + currentWeather.simpleOutput
else
  puts currentWeather
end

#currentWeather = weather.getCurrentWeatherFor(cityID)
#puts "CityID: " + currentWeather.simpleOutput
#currentWeather = weather.getCurrentWeatherFor(city)
#puts "City Name: " + currentWeather.simpleOutput
#currentWeather = weather.getCurrentWeatherAt(lat, long)
#puts "Lat and Long: " + currentWeather.simpleOutput
#currentWeather = weather.getCurrentWeatherAtZip(zip)
#puts "Zip Code: " + currentWeather.simpleOutput
