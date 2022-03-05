require "minitest/autorun"

require "json"

require "/../src/owm/client"
require "./webmocks.cr"

class ClientTest < Minitest::Test
  def client
    @client ||= OWM::Client.new("NOTAREALKEY")
  end

  def test_fetches_current_weather_from_coordinates
    params = { "lat" => 43.5, "lon" => -79.5 }
    currentWeather = client.current_weather_for_city(params)
    assert_equal OWM::CurrentWeather, currentWeather.class
  end

  def test_fetches_current_weather_for_many_cities
    params = { "id" => [6075357, 5907364, 5969785] }
    currentWeather = client.current_weather_for_cities(params)
    assert_equal Array(OWM::CurrentWeather), currentWeather.class
  end

  def test_fetches_five_day_forecast_from_name
    params = { "q" => "Mississauga" }
    forecast = client.five_day_forecast_for_city(params)
    assert_equal OWM::FiveDayForecast, forecast.class
  end

  def test_fetches_sunrise_and_sunset
    params = { "q" => "Mississauga" }
    s_and_s = sunrise_sunset_for_city = client.sunrise_sunset_for_city(params)
    assert_equal Array(Time), s_and_s.class
  end

  def test_doesnt_fetch_without_params
    params = {} of String => String
    response = assert_raises do
      client.current_weather_for_city(params)
    end
    assert_equal "Invalid Parameters", response.message
  end

  def test_raises_error_on_400
    params = { "f" => "Mississauga" }
    response = assert_raises do
      client.current_weather_for_city(params)
    end
    assert_equal "400:Bad Request", response.message
  end

  def test_raises_error_on_invalid_key
    bad_client = OWM::Client.new("InvalidKey")
    params = { "q" => "Mississauga" }
    response = assert_raises do
      bad_client.current_weather_for_city(params)
    end
    assert_equal "401:Unauthorized", response.message
  end
end
