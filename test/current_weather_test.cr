require "minitest/autorun"
require "/../src/open_weather_map/client"

class CurrentWeatherTest < Minitest::Test
  def test_fetches_weather_from_coordinates
    key = ENV["OWM"]
    client = OpenWeatherMap::Client.new(key)
    params = { "lat" => 43.5, "lon" => -79.5}
    currentWeather = client.current_weather_for_city(params)
    assert_equal currentWeather.class, OpenWeatherMap::CurrentWeather
  end
end
