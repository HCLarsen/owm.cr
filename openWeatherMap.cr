require "http/client"
require "json"

require "./client"

# A module containing classes and methods for interacting with the Open Weather
# Map API.
module HTTP
end

key = "83658a490b36698e09e779d265859910"
city = "Mississauga"
cityID = 6075357

weather = OpenWeatherMap::Client.new(key)
currentWeather = weather.getCurrentWeatherFor(city)
puts currentWeather.simpleOutput
currentWeather = weather.getCurrentWeatherFor(cityID)
puts currentWeather.simpleOutput
