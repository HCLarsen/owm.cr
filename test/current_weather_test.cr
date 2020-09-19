require "minitest/autorun"

require "json"

require "/../src/open_weather_map/current_weather"

class CurrentWeatherTest < Minitest::Test
  def cairns
    @cairns ||= OpenWeatherMap::CurrentWeather.from_json(%({"coord":{"lon":145.77,"lat":-16.92},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"base":"cmc stations","main":{"temp":293.25,"pressure":1019,"humidity":83,"temp_min":289.82,"temp_max":295.37},"wind":{"speed":5.1,"deg":150},"clouds":{"all":75},"rain":{"3h":3},"dt":1435658272,"sys":{"type":1,"id":8166,"message":0.0166,"country":"AU","sunrise":1435610796,"sunset":1435650870},"id":2172797,"name":"Cairns","cod":200}))
  end

  def tromso
    @tromso ||= OpenWeatherMap::CurrentWeather.from_json(%({"coord":{"lon":18.96,"lat":69.65},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"base":"stations","main":{"temp":270.312,"pressure":986.36,"humidity":100,"temp_min":270.312,"temp_max":270.312,"sea_level":1026.97,"grnd_level":986.36},"wind":{"speed":1.11,"deg":156},"clouds":{"all":92},"dt":1515473249,"sys":{"message":0.0037,"country":"NO","sunrise":0,"sunset":0},"id":3133895,"name":"Tromso","cod":200}))
  end

  def three_conditions
    @three_conditions ||= OpenWeatherMap::CurrentWeather.from_json(%({"coord":{"lon":-79.65,"lat":43.59},"weather":[{"id":310,"main":"Drizzle","description":"light intensity drizzle rain","icon":"09d"},{"id":500,"main":"Rain","description":"light rain","icon":"10d"},{"id":701,"main":"Mist","description":"mist","icon":"50d"}],"base":"stations","main":{"temp":273.55,"pressure":1018,"humidity":95,"temp_min":273.15,"temp_max":274.15},"visibility":12874,"wind":{"speed":2.6,"deg":130},"clouds":{"all":90},"dt":1515614520,"sys":{"type":1,"id":3722,"message":0.0041,"country":"CA","sunrise":1515588633,"sunset":1515621768},"id":6075357,"name":"Mississauga","cod":200}))
  end

  def mississauga
    @mississauga ||= OpenWeatherMap::CurrentWeather.from_json(%({"coord":{"lon":-79.65,"lat":43.59},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10n"}],"base":"stations","main":{"temp":274.14,"pressure":1013,"humidity":64,"temp_min":273.15,"temp_max":275.15},"visibility":14484,"wind":{"speed":6.2,"deg":270},"clouds":{"all":90},"dt":1515471120,"sys":{"type":1,"id":3721,"message":0.0046,"country":"CA","sunrise":1515502264,"sunset":1515535256},"id":6075357,"name":"Mississauga","cod":200}))
  end

  def test_parses_city_info
    assert_equal "Mississauga", mississauga.name
    assert_equal 6075357, mississauga.id
    assert_equal "CA", mississauga.country
    assert_equal Time.unix(1515471120), mississauga.time
  end

  def test_coords
    assert_equal 43.59, mississauga.lat
    assert_equal -79.65, mississauga.lon
  end

  def test_weather_info
    assert_equal 500, mississauga.weather_id
    assert_equal "Rain", mississauga.weather_main
    assert_equal "light rain", mississauga.weather_description
    assert_equal "10n", mississauga.weather_icon
  end

  def test_main_info
    assert_equal 274.14, mississauga.temp
    assert_equal 273.15, mississauga.temp_min
    assert_equal 275.15, mississauga.temp_max
    assert_equal 1013, mississauga.pressure
    assert_equal 64, mississauga.humidity
  end

  def test_multiple_conditions
    assert_equal 3, three_conditions.conditions.size
    assert_equal "Drizzle", three_conditions.conditions[0].main
    assert_equal "Rain", three_conditions.conditions[1].main
    assert_equal "Mist", three_conditions.conditions[2].main
  end

  def test_wind_info
    assert_equal 6, mississauga.wind_speed
    assert_equal 270, mississauga.wind_deg
  end

  def test_rain
    assert_equal 3.0, cairns.rain
  end

  def test_rain_and_snow_default_to_0
    assert_equal 0.0, mississauga.snow
    assert_equal 0.0, mississauga.rain
  end

  def test_float_pressure_processed_as_int
    assert_equal 986, tromso.pressure
    assert_equal 1027, tromso.sea_level
    assert_equal 986, tromso.grnd_level
  end

  def test_grnd_level_and_sea_level
    assert_equal 986, tromso.grnd_level
    assert_equal 1027, tromso.sea_level
  end

  def test_absent_grnd_level_and_sea_level
    assert_equal mississauga.pressure, mississauga.grnd_level
    assert_equal mississauga.pressure, mississauga.sea_level
  end
end
