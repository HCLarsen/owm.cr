require "minitest/autorun"

require "json"

require "/../src/owm/five_day_forecast"

class FiveDayForecastTest < Minitest::Test
  def mississauga : OpenWeatherMap::FiveDayForecast
    @mississauga ||= OpenWeatherMap::FiveDayForecast.from_json(%({"cod":"200","message":0.0042,"cnt":39,"list":[{"dt":1516071600,"main":{"temp":266.06,"temp_min":266.06,"temp_max":266.068,"pressure":1007.67,"sea_level":1043.23,"grnd_level":1007.67,"humidity":81,"temp_kf":-0.01},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":76},"wind":{"speed":2.12,"deg":127.507},"snow":{"3h":0.559},"sys":{"pod":"n"},"dt_txt":"2018-01-16 03:00:00"},{"dt":1516082400,"main":{"temp":265.84,"temp_min":265.84,"temp_max":265.846,"pressure":1006.32,"sea_level":1041.82,"grnd_level":1006.32,"humidity":91,"temp_kf":-0.01},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":80},"wind":{"speed":1.32,"deg":86.0011},"snow":{"3h":0.357},"sys":{"pod":"n"},"dt_txt":"2018-01-16 06:00:00"},{"dt":1516093200,"main":{"temp":265.45,"temp_min":265.45,"temp_max":265.452,"pressure":1006.23,"sea_level":1041.57,"grnd_level":1006.23,"humidity":85,"temp_kf":-0.01},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":80},"wind":{"speed":1.66,"deg":39.0026},"snow":{"3h":0.635},"sys":{"pod":"n"},"dt_txt":"2018-01-16 09:00:00"},{"dt":1516104000,"main":{"temp":264.45,"temp_min":264.45,"temp_max":264.451,"pressure":1006.26,"sea_level":1041.78,"grnd_level":1006.26,"humidity":81,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":88},"wind":{"speed":2.21,"deg":18.0024},"snow":{"3h":0.3275},"sys":{"pod":"n"},"dt_txt":"2018-01-16 12:00:00"},{"dt":1516114800,"main":{"temp":265.303,"temp_min":265.303,"temp_max":265.303,"pressure":1007.29,"sea_level":1042.83,"grnd_level":1007.29,"humidity":76,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13d"}],"clouds":{"all":80},"wind":{"speed":1.31,"deg":6.5011},"snow":{"3h":0.20625},"sys":{"pod":"d"},"dt_txt":"2018-01-16 15:00:00"},{"dt":1516125600,"main":{"temp":267.978,"temp_min":267.978,"temp_max":267.978,"pressure":1006.93,"sea_level":1042.42,"grnd_level":1006.93,"humidity":70,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13d"}],"clouds":{"all":64},"wind":{"speed":1.22,"deg":232.502},"snow":{"3h":0.24125},"sys":{"pod":"d"},"dt_txt":"2018-01-16 18:00:00"},{"dt":1516136400,"main":{"temp":268.296,"temp_min":268.296,"temp_max":268.296,"pressure":1006.99,"sea_level":1042.76,"grnd_level":1006.99,"humidity":68,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13d"}],"clouds":{"all":76},"wind":{"speed":1.61,"deg":217.503},"snow":{"3h":0.1375},"sys":{"pod":"d"},"dt_txt":"2018-01-16 21:00:00"},{"dt":1516147200,"main":{"temp":266.473,"temp_min":266.473,"temp_max":266.473,"pressure":1008.09,"sea_level":1043.91,"grnd_level":1008.09,"humidity":78,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":68},"wind":{"speed":2.06,"deg":240.001},"snow":{"3h":0.6675},"sys":{"pod":"n"},"dt_txt":"2018-01-17 00:00:00"},{"dt":1516158000,"main":{"temp":265.379,"temp_min":265.379,"temp_max":265.379,"pressure":1008.5,"sea_level":1044.38,"grnd_level":1008.5,"humidity":81,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":64},"wind":{"speed":2.31,"deg":254.503},"snow":{"3h":0.24},"sys":{"pod":"n"},"dt_txt":"2018-01-17 03:00:00"},{"dt":1516168800,"main":{"temp":264.248,"temp_min":264.248,"temp_max":264.248,"pressure":1008.2,"sea_level":1044.2,"grnd_level":1008.2,"humidity":88,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":68},"wind":{"speed":1.07,"deg":277.502},"snow":{"3h":0.067500000000001},"sys":{"pod":"n"},"dt_txt":"2018-01-17 06:00:00"},{"dt":1516179600,"main":{"temp":263.488,"temp_min":263.488,"temp_max":263.488,"pressure":1008.1,"sea_level":1044.19,"grnd_level":1008.1,"humidity":88,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"clouds":{"all":64},"wind":{"speed":1.31,"deg":281.002},"snow":{"3h":0.017499999999999},"sys":{"pod":"n"},"dt_txt":"2018-01-17 09:00:00"},{"dt":1516190400,"main":{"temp":259.104,"temp_min":259.104,"temp_max":259.104,"pressure":1008.35,"sea_level":1044.49,"grnd_level":1008.35,"humidity":78,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"clouds":{"all":0},"wind":{"speed":1.1,"deg":272.504},"snow":{},"sys":{"pod":"n"},"dt_txt":"2018-01-17 12:00:00"},{"dt":1516201200,"main":{"temp":262.355,"temp_min":262.355,"temp_max":262.355,"pressure":1008.66,"sea_level":1044.64,"grnd_level":1008.66,"humidity":72,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":{"all":0},"wind":{"speed":1.77,"deg":249.002},"snow":{},"sys":{"pod":"d"},"dt_txt":"2018-01-17 15:00:00"},{"dt":1516212000,"main":{"temp":267.405,"temp_min":267.405,"temp_max":267.405,"pressure":1006.83,"sea_level":1042.5,"grnd_level":1006.83,"humidity":61,"temp_kf":0},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02d"}],"clouds":{"all":12},"wind":{"speed":2.51,"deg":254},"snow":{},"sys":{"pod":"d"},"dt_txt":"2018-01-17 18:00:00"},{"dt":1516222800,"main":{"temp":267.302,"temp_min":267.302,"temp_max":267.302,"pressure":1004.98,"sea_level":1040.37,"grnd_level":1004.98,"humidity":61,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":{"all":56},"wind":{"speed":3.16,"deg":267.501},"snow":{"3h":0.015000000000001},"sys":{"pod":"d"},"dt_txt":"2018-01-17 21:00:00"},{"dt":1516233600,"main":{"temp":263.915,"temp_min":263.915,"temp_max":263.915,"pressure":1004.55,"sea_level":1039.95,"grnd_level":1004.55,"humidity":69,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"clouds":{"all":0},"wind":{"speed":3.31,"deg":256.5},"snow":{"3h":0.0075000000000003},"sys":{"pod":"n"},"dt_txt":"2018-01-18 00:00:00"},{"dt":1516244400,"main":{"temp":262.021,"temp_min":262.021,"temp_max":262.021,"pressure":1002.6,"sea_level":1038.07,"grnd_level":1002.6,"humidity":80,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"clouds":{"all":0},"wind":{"speed":3.71,"deg":239.501},"snow":{"3h":0.0024999999999995},"sys":{"pod":"n"},"dt_txt":"2018-01-18 03:00:00"},{"dt":1516255200,"main":{"temp":262.361,"temp_min":262.361,"temp_max":262.361,"pressure":999.91,"sea_level":1035.33,"grnd_level":999.91,"humidity":83,"temp_kf":0},"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03n"}],"clouds":{"all":32},"wind":{"speed":4.21,"deg":246.002},"snow":{},"sys":{"pod":"n"},"dt_txt":"2018-01-18 06:00:00"},{"dt":1516266000,"main":{"temp":262.412,"temp_min":262.412,"temp_max":262.412,"pressure":997.61,"sea_level":1033.02,"grnd_level":997.61,"humidity":83,"temp_kf":0},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02n"}],"clouds":{"all":12},"wind":{"speed":4.42,"deg":252.501},"snow":{},"sys":{"pod":"n"},"dt_txt":"2018-01-18 09:00:00"},{"dt":1516276800,"main":{"temp":262.564,"temp_min":262.564,"temp_max":262.564,"pressure":996.18,"sea_level":1031.5,"grnd_level":996.18,"humidity":82,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"clouds":{"all":32},"wind":{"speed":4.41,"deg":245.508},"snow":{"3h":0.015},"sys":{"pod":"n"},"dt_txt":"2018-01-18 12:00:00"},{"dt":1516287600,"main":{"temp":264.003,"temp_min":264.003,"temp_max":264.003,"pressure":995.82,"sea_level":1031,"grnd_level":995.82,"humidity":68,"temp_kf":0},"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"clouds":{"all":44},"wind":{"speed":4.67,"deg":243.001},"snow":{},"sys":{"pod":"d"},"dt_txt":"2018-01-18 15:00:00"},{"dt":1516298400,"main":{"temp":267.491,"temp_min":267.491,"temp_max":267.491,"pressure":994.34,"sea_level":1029.27,"grnd_level":994.34,"humidity":72,"temp_kf":0},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"clouds":{"all":68},"wind":{"speed":4.86,"deg":251.002},"snow":{},"sys":{"pod":"d"},"dt_txt":"2018-01-18 18:00:00"},{"dt":1516309200,"main":{"temp":269.61,"temp_min":269.61,"temp_max":269.61,"pressure":993.84,"sea_level":1028.59,"grnd_level":993.84,"humidity":71,"temp_kf":0},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"clouds":{"all":80},"wind":{"speed":4.71,"deg":263},"snow":{},"sys":{"pod":"d"},"dt_txt":"2018-01-18 21:00:00"},{"dt":1516320000,"main":{"temp":269.12,"temp_min":269.12,"temp_max":269.12,"pressure":994.72,"sea_level":1029.35,"grnd_level":994.72,"humidity":81,"temp_kf":0},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02n"}],"clouds":{"all":20},"wind":{"speed":4.56,"deg":261.508},"snow":{},"sys":{"pod":"n"},"dt_txt":"2018-01-19 00:00:00"},{"dt":1516330800,"main":{"temp":269.297,"temp_min":269.297,"temp_max":269.297,"pressure":994.79,"sea_level":1029.42,"grnd_level":994.79,"humidity":83,"temp_kf":0},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02n"}],"clouds":{"all":20},"wind":{"speed":4.66,"deg":257.003},"snow":{},"sys":{"pod":"n"},"dt_txt":"2018-01-19 03:00:00"},{"dt":1516341600,"main":{"temp":269.092,"temp_min":269.092,"temp_max":269.092,"pressure":994.53,"sea_level":1029.25,"grnd_level":994.53,"humidity":88,"temp_kf":0},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"clouds":{"all":56},"wind":{"speed":4.7,"deg":261.001},"snow":{},"sys":{"pod":"n"},"dt_txt":"2018-01-19 06:00:00"},{"dt":1516352400,"main":{"temp":268.214,"temp_min":268.214,"temp_max":268.214,"pressure":995.04,"sea_level":1029.74,"grnd_level":995.04,"humidity":86,"temp_kf":0},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"clouds":{"all":76},"wind":{"speed":4.01,"deg":250.5},"snow":{},"sys":{"pod":"n"},"dt_txt":"2018-01-19 09:00:00"},{"dt":1516363200,"main":{"temp":267.379,"temp_min":267.379,"temp_max":267.379,"pressure":995.57,"sea_level":1030.39,"grnd_level":995.57,"humidity":80,"temp_kf":0},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"clouds":{"all":76},"wind":{"speed":4.14,"deg":243.502},"snow":{},"sys":{"pod":"n"},"dt_txt":"2018-01-19 12:00:00"},{"dt":1516374000,"main":{"temp":268.298,"temp_min":268.298,"temp_max":268.298,"pressure":995.84,"sea_level":1030.63,"grnd_level":995.84,"humidity":79,"temp_kf":0},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"clouds":{"all":80},"wind":{"speed":4.59,"deg":238.004},"snow":{},"sys":{"pod":"d"},"dt_txt":"2018-01-19 15:00:00"},{"dt":1516384800,"main":{"temp":272.13,"temp_min":272.13,"temp_max":272.13,"pressure":994.45,"sea_level":1028.85,"grnd_level":994.45,"humidity":67,"temp_kf":0},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02d"}],"clouds":{"all":20},"wind":{"speed":5.28,"deg":239.502},"snow":{},"sys":{"pod":"d"},"dt_txt":"2018-01-19 18:00:00"},{"dt":1516395600,"main":{"temp":273.147,"temp_min":273.147,"temp_max":273.147,"pressure":993.43,"sea_level":1027.58,"grnd_level":993.43,"humidity":70,"temp_kf":0},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02d"}],"clouds":{"all":12},"wind":{"speed":5.29,"deg":235.51},"snow":{},"sys":{"pod":"d"},"dt_txt":"2018-01-19 21:00:00"},{"dt":1516406400,"main":{"temp":270.892,"temp_min":270.892,"temp_max":270.892,"pressure":993.69,"sea_level":1027.95,"grnd_level":993.69,"humidity":83,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"02n"}],"clouds":{"all":8},"wind":{"speed":5.64,"deg":234.001},"snow":{},"sys":{"pod":"n"},"dt_txt":"2018-01-20 00:00:00"},{"dt":1516417200,"main":{"temp":270.048,"temp_min":270.048,"temp_max":270.048,"pressure":993.52,"sea_level":1027.84,"grnd_level":993.52,"humidity":78,"temp_kf":0},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02n"}],"clouds":{"all":12},"wind":{"speed":6.18,"deg":235.501},"snow":{},"sys":{"pod":"n"},"dt_txt":"2018-01-20 03:00:00"},{"dt":1516428000,"main":{"temp":270.418,"temp_min":270.418,"temp_max":270.418,"pressure":993.1,"sea_level":1027.39,"grnd_level":993.1,"humidity":84,"temp_kf":0},"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03n"}],"clouds":{"all":44},"wind":{"speed":6.76,"deg":235.001},"snow":{},"sys":{"pod":"n"},"dt_txt":"2018-01-20 06:00:00"},{"dt":1516438800,"main":{"temp":271.177,"temp_min":271.177,"temp_max":271.177,"pressure":993.23,"sea_level":1027.51,"grnd_level":993.23,"humidity":84,"temp_kf":0},"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03n"}],"clouds":{"all":32},"wind":{"speed":6.61,"deg":237.504},"snow":{},"sys":{"pod":"n"},"dt_txt":"2018-01-20 09:00:00"},{"dt":1516449600,"main":{"temp":271.91,"temp_min":271.91,"temp_max":271.91,"pressure":993.71,"sea_level":1027.89,"grnd_level":993.71,"humidity":83,"temp_kf":0},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"clouds":{"all":80},"wind":{"speed":5.99,"deg":237.501},"snow":{},"sys":{"pod":"n"},"dt_txt":"2018-01-20 12:00:00"},{"dt":1516460400,"main":{"temp":273.985,"temp_min":273.985,"temp_max":273.985,"pressure":994.41,"sea_level":1028.54,"grnd_level":994.41,"humidity":86,"temp_kf":0},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"clouds":{"all":88},"wind":{"speed":6.1,"deg":235.5},"rain":{"3h":0.07},"snow":{},"sys":{"pod":"d"},"dt_txt":"2018-01-20 15:00:00"},{"dt":1516471200,"main":{"temp":275.828,"temp_min":275.828,"temp_max":275.828,"pressure":994.04,"sea_level":1027.95,"grnd_level":994.04,"humidity":88,"temp_kf":0},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"clouds":{"all":92},"wind":{"speed":6.12,"deg":236.503},"rain":{"3h":0.22},"snow":{},"sys":{"pod":"d"},"dt_txt":"2018-01-20 18:00:00"},{"dt":1516482000,"main":{"temp":276.528,"temp_min":276.528,"temp_max":276.528,"pressure":994.42,"sea_level":1028.2,"grnd_level":994.42,"humidity":90,"temp_kf":0},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"clouds":{"all":88},"wind":{"speed":5.55,"deg":237},"rain":{"3h":0.25},"snow":{},"sys":{"pod":"d"},"dt_txt":"2018-01-20 21:00:00"}],"city":{"id":6075357,"name":"Mississauga","coord":{"lat":43.5903,"lon":-79.6458},"country":"CA","population":9999}}))
  end

  def test_parses_json
    assert_equal OpenWeatherMap::FiveDayForecast, mississauga.class
    assert_equal "Mississauga", mississauga.name
    assert_equal "CA", mississauga.country
    assert_equal 6075357, mississauga.id
    assert_equal 43.5903, mississauga.lat
  end

  def test_weather_list
    assert_equal 39, mississauga.list.size
    assert_equal OpenWeatherMap::Conditions, mississauga.list.first.class
  end

  def test_weather
    forecast = mississauga.list.first
    assert_equal Time.unix(1516071600), forecast.time
    assert_equal 266.06, forecast.temp
    assert_equal "Snow", forecast.weather_main
    assert_equal 76, forecast.clouds
    assert_equal 0.559, forecast.snow
    assert_equal 2, forecast.wind_speed
  end
end
