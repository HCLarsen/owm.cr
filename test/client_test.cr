require "minitest/autorun"

require "json"

require "/../src/open_weather_map/client"

class ClientTest < Minitest::Test
  #  def test_fetches_weather_from_coordinates
  #    key = ENV["OWM"]
  #    client = OpenWeatherMap::Client.new(key)
  #    params = { "lat" => 43.5, "lon" => -79.5}
  #    currentWeather = client.current_weather_for_city(params)
  #    assert_equal currentWeather.class, OpenWeatherMap::CurrentWeather
  #  end
  #
  #  def test_doesnt_fetch_without_params
  #    key = ENV["OWM"]
  #    client = OpenWeatherMap::Client.new(key)
  #    params = {} of String => String
  #    currentWeather = client.current_weather_for_city(params)
  #    assert_equal currentWeather.class, String
  #  end
end
