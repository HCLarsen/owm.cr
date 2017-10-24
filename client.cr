require "http/client"
require "json"

require "./current_weather"

# A client for interfacing with the Open Weather Map API.
class OpenWeatherMap::Client
  @@base_address = "http://api.openweathermap.org/data/2.5/"
  def initialize(key : String)
    @key = key
  end

  # Requests current weather information for a single city by passing in the city
  # name.
  def currentWeatherForCity(q : String)
    params = { "APPID" => @key }
    address = @@base_address + "/weather?q=#{q}&" + HTTP::Params.encode(params)
    getCurrentWeather address
  end

  # Requests current weather information for a single city by passing in the city
  # id as an int
  def currentWeatherForCity(id : Int32)
    params = { "APPID" => @key }
    address = @@base_address + "/weather?id=#{id}&" + HTTP::Params.encode(params)
    getCurrentWeather address
  end

  # Requests current weather information for a single city by passing in latitude
  # and longitude values.
  def currentWeatherForCity(lat : Float64, lon : Float64)
    address = @@base_address + "/weather?lat=#{lat}&lon=#{lon}&" + HTTP::Params.encode({ "APPID" => @key })
    getCurrentWeather address
  end

  # Requests current weather information for a single city by passing in the zip
  # code. Works for US addresses only.
  def currentWeatherForCity(*, zip : Int)
    params = { "APPID" => @key }
    address = @@base_address + "/weather?zip=#{zip},us&" + HTTP::Params.encode(params)
    getCurrentWeather address
  end

  # Requests current weather information for cities within a box bounded by latitude
  # and longitude coordinates. Returns an array of CurrentWeather objects.
  def currentWeatherForCities(lon_left : Float64, lat_bottom : Float64, lon_right : Float64, lat_top : Float64, zoom : Int32)
    params = { "APPID" => @key }
    address = @@base_address + "/box/city?bbox=#{lon_left},#{lat_bottom},#{lon_right},#{lat_top},#{zoom}&" + HTTP::Params.encode(params)
    getCurrentWeather address
  end

  # Requests current weather information for cities within a circle of specified
  # diameter originating at the specified coordinates. Returns an array of
  # CurrentWeather objects.
  def currentWeatherForCities(lat : Float64, lon : Float64, cnt : Int32)
    address = @@base_address + "/find?lat=#{lat}&lon=#{lon}&cnt=#{cnt}&" + HTTP::Params.encode({ "APPID" => @key })
    getCurrentWeather address
  end

  # Requests current weather information for multiple cities by passing in an array
  # of city IDs. Returns an array of CurrentWeather objects.
  def currentWeatherForCities(id : Array(Int32))
    params = { "APPID" => @key }
    ids = id.to_s.lchop.rchop.split.join
    address = @@base_address + "/group?id=#{ids}&" + HTTP::Params.encode(params)
    getCurrentWeather address
  end

  private def getCurrentWeather(address : String)
    response = HTTP::Client.get address
    value = JSON.parse(response.body)
    if 200 <= response.status_code < 300
      if value.as_h.has_key? "list"
        cities = value["list"]
        cities.map do |city|
          CurrentWeather.new(city)
        end
      else
        CurrentWeather.new(value)
      end
    else
      value["message"].as_s
    end
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
    getCurrentWeather address
  end
end
