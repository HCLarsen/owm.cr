require "minitest/autorun"

require "json"

require "/../src/owm/five_day_forecast"

class FiveDayForecastTest < Minitest::Test
  def mississauga : OWM::FiveDayForecast
    @mississauga ||= OWM::FiveDayForecast.from_json(File.read("test/files/fiveday.json")) 
  end

  def test_parses_json
    assert_equal OWM::FiveDayForecast, mississauga.class
    assert_equal "Mississauga", mississauga.name
    assert_equal "CA", mississauga.country
    assert_equal 6075357, mississauga.id
    assert_equal 43.5903, mississauga.lat
  end

  def test_weather_list
    assert_equal 39, mississauga.list.size
    assert_equal OWM::Conditions, mississauga.list.first.class
  end

  def test_weather
    forecast = mississauga.list.first
    assert_equal Time.unix(1516071600), forecast.time
    assert_equal 266.06, forecast.main.temp
    assert_equal "Snow", forecast.weather[0].main
    assert_equal 76, forecast.clouds
    assert_equal 0.559, forecast.snow.amount
    assert_equal "3h", forecast.snow.duration
    assert_equal 2, forecast.wind.speed
  end
end
