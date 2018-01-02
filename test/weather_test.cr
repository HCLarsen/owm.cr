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
    assert_equal weather.time, Time.epoch(1406106000).to_local
    assert_equal weather.temp, 298.77
    assert_equal weather.temp_min, 298.77
    assert_equal weather.temp_max, 298.774
    assert_equal weather.weather_id, 804
    assert_equal weather.weather_main, "Clouds"
    assert_equal weather.weather_description, "overcast clouds"
    assert_equal weather.weather_icon, "04d"
    assert_equal weather.wind_speed, 6
    assert_equal weather.pressure, 1006
    assert_equal weather.humidity, 87
    assert_equal weather.clouds, 88
  end

  def test_rain
    assert_equal london.rain, 3.325
  end

  def test_empty_rain_key
    # At times, the API will return rain data as thus: rain:{}. This should still return 0.0.
    assert_equal london_no_rain.rain, 0.0
  end

  def test_snow
    assert_equal port_credit.snow, 0.405
  end

  def test_empty_snow_key
    # At times, the API will return snow data as thus: snow:{}. This should still return 0.0.
    assert_equal port_credit_no_snow.snow, 0.0
  end

  def test_rain_and_snow_default_to_0
    assert_equal weather.rain, 0.0
    assert_equal weather.snow, 0.0
  end

  def test_grnd_level_and_sea_level_default_to_pressure
    assert_equal weather.pressure, weather.sea_level
    assert_equal weather.pressure, weather.grnd_level
  end
end
