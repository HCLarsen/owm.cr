require "http/client"
require "json"

require "./current_weather"

# A client for interfacing with the Open Weather Map API.
class OpenWeatherMap::Client
  @@base_address = "http://api.openweathermap.org/data/2.5/"
  def initialize(key : String)
    @key = key
  end

  # Requests current weather information for a single city by passing in required
  # parameters as a hash.
  # The Hash must have one of the following keys:
  # q : Querying by the city name.
  # id : Querying by the city ID.
  # lat & lon : Querying by latitudinal and longitudinal values.
  # zip : For American addresses, querying by the zip code.
  def getCurrentWeatherFor(params : Hash)
    params["APPID"] = @key
    address = @@base_address + "/weather?" + HTTP::Params.encode(params)
    response = HTTP::Client.get address
    value = JSON.parse(response.body)
    if value["cod"].as_i >= 200 && value["cod"].as_i <= 299
      CurrentWeather.new(value)
    else
      value["message"].as_s
    end
  end
end
