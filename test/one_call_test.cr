require "minitest/autorun"

require "/../src/owm/one_call"

class OneCallTest < Minitest::Test
  def test_parses_current_object
    json = %({"dt":1646522343,"sunrise":1646480913,"sunset":1646521920,"temp":274.3,"feels_like":270.56,"pressure":1018,"humidity":77,"dew_point":271,"uvi":0,"clouds":100,"visibility":10000,"wind_speed":3.6,"wind_deg":90,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}]})
    current = OWM::OneCall::Current.from_json(json)

    assert_equal Time.unix(1646522343), current.time
    assert_equal Time.unix(1646480913), current.sunrise
    assert_equal Time.unix(1646521920), current.sunset
    assert_equal 274, current.temp
    assert_equal 271, current.feels_like
    assert_equal 1018, current.pressure
    assert_equal 77, current.humidity
    assert_equal 271, current.dew_point
    assert_equal 0.0, current.uvi
    assert_equal 100, current.clouds
    assert_equal 10000, current.visibility
    assert_equal 3.6, current.wind_speed
    assert_equal 90, current.wind_deg

    assert_equal 0.0, current.rain.amount
    assert_equal 0.0, current.snow.amount

    assert_equal 804, current.weather[0].id
    assert_equal "Clouds", current.weather[0].main
    assert_equal "overcast clouds", current.weather[0].description
    assert_equal "04n", current.weather[0].icon
  end

  def test_parses_minutely_forecast
    json = %({"dt":1646522400,"precipitation":0})
    minutely = OWM::OneCall::Minutely.from_json(json)

    assert_equal Time.unix(1646522400), minutely.time
    assert_equal 0.0, minutely.precipitation
  end

  def test_parses_hourly_forecast
    json = %({"dt":1646521200,"temp":274.3,"feels_like":270.25,"pressure":1018,"humidity":77,"dew_point":271,"uvi":0,"clouds":100,"visibility":10000,"wind_speed":4.05,"wind_deg":84,"wind_gust":8.68,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"pop":0})
    hourly = OWM::OneCall::Hourly.from_json(json)

    assert_equal Time.unix(1646521200), hourly.time
    assert_equal 274, hourly.temp
    assert_equal 270, hourly.feels_like
    assert_equal 1018, hourly.pressure
    assert_equal 77, hourly.humidity
    assert_equal 271, hourly.dew_point
    assert_equal 0.0, hourly.uvi
    assert_equal 100, hourly.clouds
    assert_equal 10000, hourly.visibility
    assert_equal 4.05, hourly.wind_speed
    assert_equal 84, hourly.wind_deg
    assert_equal 8.68, hourly.wind_gust
    assert_equal 0.0, hourly.pop

    assert_equal 0.0, hourly.rain.amount
    assert_equal 0.0, hourly.snow.amount

    assert_equal 804, hourly.weather[0].id
    assert_equal "Clouds", hourly.weather[0].main
    assert_equal "overcast clouds", hourly.weather[0].description
    assert_equal "04d", hourly.weather[0].icon
  end

  def test_parses_daily_forecast
    json = %({"dt":1646499600,"sunrise":1646480913,"sunset":1646521920,"moonrise":1646486700,"moonset":1646534340,"moon_phase":0.1,"temp":{"day":273.83,"min":269.63,"max":274.3,"night":273.8,"eve":274.3,"morn":269.95},"feels_like":{"day":269.05,"night":273.8,"eve":270.25,"morn":269.95},"pressure":1026,"humidity":54,"dew_point":265.68,"wind_speed":5.67,"wind_deg":87,"wind_gust":9.5,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":100,"pop":0,"uvi":2.96})
    daily = OWM::OneCall::Daily.from_json(json)

    assert_equal Time.unix(1646499600), daily.time
    assert_equal Time.unix(1646480913), daily.sunrise
    assert_equal Time.unix(1646521920), daily.sunset
    assert_equal Time.unix(1646486700), daily.moonrise
    assert_equal Time.unix(1646534340), daily.moonset
    assert_equal 0.1, daily.moon_phase

    assert_equal 274, daily.temp.day
    assert_equal 270, daily.temp.min
    assert_equal 274, daily.temp.max
    assert_equal 274, daily.temp.night
    assert_equal 274, daily.temp.eve
    assert_equal 270, daily.temp.morn

    assert_equal 269, daily.feels_like.day
    assert_equal 274, daily.feels_like.night
    assert_equal 270, daily.feels_like.eve
    assert_equal 270, daily.feels_like.morn

    assert_equal 1026, daily.pressure
    assert_equal 54, daily.humidity
    assert_equal 266, daily.dew_point

    assert_equal 5.67, daily.wind_speed
    assert_equal 87, daily.wind_deg
    assert_equal 9.5, daily.wind_gust

    assert_equal 0.0, daily.rain
    assert_equal 0.0, daily.snow

    assert_equal 804, daily.weather[0].id
    assert_equal "Clouds", daily.weather[0].main
    assert_equal "overcast clouds", daily.weather[0].description
    assert_equal "04d", daily.weather[0].icon

    assert_equal 100, daily.clouds
    assert_equal 0.0, daily.pop
    assert_equal 2.96, daily.uvi
  end

  def test_parses_alert
    json = %({"sender_name":"Environment Canada","event":"weather","start":1646504708,"end":1646562308,"description":"\nStrong winds are expected Sunday.\n\nHazard:\nStrong wind gusts of 80 to 90 km/h. Localized gusts in excess of 100 km/h are possible.\nWidespread power outages are possible.\n\nTiming:\nSunday morning and afternoon.\n\nDiscussion:\nStrong southwest winds will develop late Sunday morning or early Sunday afternoon as a cold front moves through southern Ontario. Thunderstorms developing along this cold front may bring localized wind gusts in excess of 100 km/h.\n\n###\n\nPlease continue to monitor alerts and forecasts issued by Environment Canada. To report severe weather, send an email to ONstorm@ec.gc.ca or tweet reports using #ONStorm.\n","tags":[]})
    alert = OWM::OneCall::Alert.from_json(json.gsub("\n", "\\n"))

    assert_equal "Environment Canada", alert.sender_name
    assert_equal "weather", alert.event
    assert_equal Time.unix(1646504708), alert.start_time
    assert_equal Time.unix(1646562308), alert.end_time
    assert_equal "\nStrong winds are expected Sunday.", alert.description[0..33]
    assert_equal [] of String, alert.tags
  end

  def test_parses_one_call
    json = File.read("test/files/onecall.json")
    one_call = OWM::OneCall.from_json(json)

    assert_equal 43.5789, one_call.lat
    assert_equal -79.6583, one_call.lon
    assert_equal "America/Toronto", one_call.timezone
    assert_equal -18000, one_call.timezone_offset

    assert_equal 274, one_call.current.temp
    assert_equal 0.0, one_call.minutely[0].precipitation
    assert_equal 8.68, one_call.hourly[0].wind_gust
    assert_equal 266, one_call.daily[0].dew_point
    assert_equal "Environment Canada", one_call.alerts[0].sender_name
  end

  def test_parses_one_call_without_alert
    json = File.read("test/files/weekdayweather.json")
    one_call = OWM::OneCall.from_json(json)

  end
end
