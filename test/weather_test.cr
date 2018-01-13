require "minitest/autorun"

require "json"

require "/../src/open_weather_map/weather"

class CurrentWeatherTest < Minitest::Test
  def port_credit
    # Includes snow
    @port_credit ||= OpenWeatherMap::Weather.from_json(%({"dt":1515013200,"main":{"temp":260.359,"temp_min":260.359,"temp_max":260.359,"pressure":991.62,"sea_level":1026.9,"grnd_level":991.62,"humidity":62,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13d"}],"clouds":{"all":88},"wind":{"speed":4.4,"deg":242.01},"snow":{"3h":0.405},"sys":{"pod":"d"},"dt_txt":"2018-01-03 21:00:00"}))
  end

  def port_credit_no_snow
    # Includes a snow key with an empty subobject
    @port_credit ||= OpenWeatherMap::Weather.from_json(%({"dt":1515272400,"main":{"temp":258.931,"temp_min":258.931,"temp_max":258.931,"pressure":1007.08,"sea_level":1043.8,"grnd_level":1007.08,"humidity":48,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":{"all":0},"wind":{"speed":4.11,"deg":305.007},"snow":{},"sys":{"pod":"d"},"dt_txt":"2018-01-06 21:00:00"}))
  end

  def london
    # Includes rain
    @london ||= OpenWeatherMap::Weather.from_json(%({"dt":1514948400,"main":{"temp":281.062,"temp_min":281.062,"temp_max":281.062,"pressure":998.01,"sea_level":1005.51,"grnd_level":998.01,"humidity":95,"temp_kf":0},"weather":[{"id":501,"main":"Rain","description":"moderate rain","icon":"10n"}],"clouds":{"all":68},"wind":{"speed":10.32,"deg":263},"rain":{"3h":3.325},"sys":{"pod":"n"},"dt_txt":"2018-01-03 03:00:00"}))
  end

  def london_no_rain
    # Has a rain entry, but it's empty
    @london_no_rain ||= OpenWeatherMap::Weather.from_json(%({"dt":1514883600,"main":{"temp":276.7,"temp_min":276.7,"temp_max":277.372,"pressure":1017.68,"sea_level":1025.56,"grnd_level":1017.68,"humidity":77,"temp_kf":-0.67},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"clouds":{"all":64},"wind":{"speed":3.53,"deg":228.5},"rain":{},"sys":{"pod":"d"},"dt_txt":"2018-01-02 09:00:00"}))
  end

  def weather
    @weather ||= OpenWeatherMap::Weather.from_json(%({"dt":1406106000,"main":{"temp":298.77,"temp_min":298.77,"temp_max":298.774, "pressure":1005.93,"humidity":87,"temp_kf":0.26},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":{"all":88},"wind":{"speed":5.71,"deg":229.501},"sys":{"pod":"d"},"dt_txt":"2014-07-23 09:00:00"}))
  end

  def test_parses_json
    assert_equal Time.epoch(1406106000).to_local, weather.time
    assert_equal 298.77, weather.temp
    assert_equal 298.77, weather.temp_min
    assert_equal 298.774, weather.temp_max
    assert_equal 804, weather.weather_id
    assert_equal "Clouds", weather.weather_main
    assert_equal "overcast clouds", weather.weather_description
    assert_equal "04d", weather.weather_icon
    assert_equal 6, weather.wind_speed
    assert_equal 1006, weather.pressure
    assert_equal 87, weather.humidity
    assert_equal 88, weather.clouds
  end

  def test_rain
    assert_equal 3.325, london.rain
  end

  def test_empty_rain_key
    # At times, the API will return rain data as thus: rain:{}. This should still return 0.0.
    assert_equal 0.0, london_no_rain.rain
  end

  def test_snow
    assert_equal 0.405, port_credit.snow
  end

  def test_empty_snow_key
    # At times, the API will return snow data as thus: snow:{}. This should still return 0.0.
    assert_equal 0.0, port_credit_no_snow.snow
  end

  def test_rain_and_snow_default_to_0
    assert_equal 0.0, weather.rain
    assert_equal 0.0, weather.snow
  end

  def test_absent_grnd_level_and_sea_level
    assert_equal weather.pressure, weather.sea_level
    assert_equal weather.pressure, weather.grnd_level
  end
end
