require "http/client"
require "json"

require "./current_weather"

# A client for interfacing with the Open Weather Map API.
class OpenWeatherMap::Client
  @@base_address = "http://api.openweathermap.org/data/2.5/"
  def initialize(key : String)
    @key = key
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

  private def get_current_weather(address : String, input_params : Hash(String, _) )
    params = { "APPID" => @key }
    input_params.each do |k,v|
      case v
      when Array
        params[k] = v.to_s.lchop.rchop.split.join
      when String
        params[k] = v
      else
        params[k] = v.to_s
      end
    end

    puts params
    address += HTTP::Params.encode(params)
    puts address

    response = HTTP::Client.get address
    JSON.parse(response.body)
  end

  # Requests current weather information for a single city by passing in required
  # parameters as a hash.
  # The Hash must have one of the following sets of keys:
  # q : Querying by the city name.
  # id : Querying by the city ID.
  # lat & lon : Querying by latitudinal and longitudinal values.
  # zip : For American addresses, querying by the zip code.
  def current_weather_for_city(params : Hash(String, _) )
    value = get_current_weather(@@base_address + "weather?", params)
    if 200 <= value["cod"].as_i < 300
      CurrentWeather.new(value)
    else
      value["message"].as_s
    end
  end

  def current_weather_for_cities(params : Hash(String, _) )
    case
    when params.keys.includes?("lat") && params.keys.includes?("lon") && params.keys.includes?("cnt")
      address = @@base_address + "find?"
    when params.keys.includes?("bbox")
      address = @@base_address + "bbox?"
    when params.keys.includes?("id")
      address = @@base_address + "id?"
    else
      return "Invalid Parameters"
    end
    value = get_current_weather(address, params)
    if "200" <= value["cod"].as_s < "300"
      cities = value["list"]
      cities.map do |city|
        CurrentWeather.new(city)
      end
    else
      value["message"].as_s
    end
  end
end
