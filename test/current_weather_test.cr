require "minitest/autorun"

require "json"

require "/../src/open_weather_map/current_weather"

class CurrentWeatherTest < Minitest::Test
  def tromso
    @tromso ||= OpenWeatherMap::CurrentWeather.from_json(%({"coord":{"lon":18.96,"lat":69.65},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"base":"stations","main":{"temp":270.312,"pressure":986.36,"humidity":100,"temp_min":270.312,"temp_max":270.312,"sea_level":1026.97,"grnd_level":986.36},"wind":{"speed":1.11,"deg":156},"clouds":{"all":92},"dt":1515473249,"sys":{"message":0.0037,"country":"NO","sunrise":0,"sunset":0},"id":3133895,"name":"Tromso","cod":200}))
  end

  def mississauga
    @mississauga ||= OpenWeatherMap::CurrentWeather.from_json(%({"coord":{"lon":-79.65,"lat":43.59},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10n"}],"base":"stations","main":{"temp":274.14,"pressure":1013,"humidity":64,"temp_min":273.15,"temp_max":275.15},"visibility":14484,"wind":{"speed":6.2,"deg":270},"clouds":{"all":90},"dt":1515471120,"sys":{"type":1,"id":3721,"message":0.0046,"country":"CA","sunrise":1515502264,"sunset":1515535256},"id":6075357,"name":"Mississauga","cod":200}))
  end

  def test_parses_city_info
    assert_equal mississauga.name, "Mississauga"
    assert_equal mississauga.id, 6075357
    assert_equal mississauga.time, Time.epoch(1515471120).to_local
  end

  def test_coords
    assert_equal mississauga.lat, 43.59
    assert_equal mississauga.lon, -79.65
  end

  def test_weather_info
    assert_equal mississauga.weather_id, 500
    assert_equal mississauga.weather_main, "Rain"
    assert_equal mississauga.weather_description, "light rain"
    assert_equal mississauga.weather_icon, "10n"
  end

  def test_main_info
    assert_equal mississauga.temp, 274.14
    assert_equal mississauga.temp_min, 273.15
    assert_equal mississauga.temp_max, 275.15
    assert_equal mississauga.pressure, 1013
    assert_equal mississauga.humidity, 64
  end

  def test_wind_info
    assert_equal mississauga.wind_speed, 6
    assert_equal mississauga.wind_deg, 270
  end

  def test_float_pressure_processed_as_int
    assert_equal tromso.pressure, 986
  end

  def test_grnd_level_and_sea_level
    assert_equal tromso.grnd_level, 986
    assert_equal tromso.sea_level, 1027
  end

  def test_absent_grnd_level_and_sea_level
    assert_equal mississauga.pressure, mississauga.grnd_level
    assert_equal mississauga.pressure, mississauga.sea_level
  end
end
