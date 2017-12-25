require "minitest/autorun"

require "json"

require "/../src/open_weather_map/current_weather"

class CurrentWeatherTest < Minitest::Test
  def test_parses_json
    value = JSON.parse(%({"coord":{"lon":-79.5,"lat":43.5},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"base":"stations","main":{"temp":277.44,"pressure":1006,"humidity":63,"temp_min":276.15,"temp_max":279.15},"visibility":14484,"wind":{"speed":8.2,"deg":260,"gust":13.4},"clouds":{"all":1},"dt":1513724400,"sys":{"type":1,"id":3721,"message":0.2431,"country":"CA","sunrise":1513687641,"sunset":1513719852},"id":6111708,"name":"Port Credit","cod":200}))
    currentWeather = OpenWeatherMap::Weather.new(value)
    assert_equal currentWeather.time, Time.epoch(1513724400).to_local
    assert_equal currentWeather.temp, 4.3
    assert_equal currentWeather.temp_min, 3
    assert_equal currentWeather.temp_max, 6
    assert_equal currentWeather.weather_id, 800
    assert_equal currentWeather.weather_main, "Clear"
    assert_equal currentWeather.weather_description, "clear sky"
    assert_equal currentWeather.weather_icon, "01n"
    assert_equal currentWeather.wind_speed, 8
    assert_equal currentWeather.pressure, 1006
    assert_equal currentWeather.humidity, 63
    assert_equal currentWeather.snow, 0
    assert_equal currentWeather.rain, 0
  end
end
