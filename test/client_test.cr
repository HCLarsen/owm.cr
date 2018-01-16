require "minitest/autorun"

require "json"

require "/../src/open_weather_map/client"

class ClientTest < Minitest::Test
  def client
    @client ||= OpenWeatherMap::Client.new(ENV["OWM_TEST"])
  end

  def test_fetches_current_weather_from_coordinates
    params = { "lat" => 43.5, "lon" => -79.5 }
    currentWeather = client.current_weather_for_city(params)
    assert_equal OpenWeatherMap::CurrentWeather, currentWeather.class
  end

  def test_fetches_current_weather_for_many_cities
    params = { "id" => [6075357, 5907364, 5969785] }
    currentWeather = client.current_weather_for_cities(params)
    assert_equal Array(OpenWeatherMap::CurrentWeather), currentWeather.class
  end

  def test_fetches_five_day_forecast_from_name
    params = { "q" => "Mississauga" }
    forecast = client.five_day_forecast_for_city(params)
    assert_equal OpenWeatherMap::FiveDayForecast, forecast.class
  end

  def test_fetches_sunrise_and_sunset
    params = { "q" => "Mississauga" }
    s_and_s = sunrise_sunset_for_city = client.sunrise_sunset_for_city(params)
    assert_equal Array(Time), s_and_s.class
  end

  def test_doesnt_fetch_without_params
    params = {} of String => String
    currentWeather = client.current_weather_for_city(params)
    assert_equal currentWeather.class, String
  end
end
