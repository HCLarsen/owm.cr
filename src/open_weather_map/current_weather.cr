require "./weather"

# Contains all the information on the current weather status for any city.
class OpenWeatherMap::CurrentWeather < OpenWeatherMap::Weather
  JSON.mapping(
    name: { type: String, setter: false },
    id: { type: Int32, setter: false },
    time: { type: Time, key: "dt", setter: false, converter: Time::EpochConverter },
    coord: { type: Coord, getter: false, setter: false },
    main: { type: Main, getter: false, setter: false },
    wind: { type: Wind, getter: false, setter: false },
    conditions: { type: Array(Conditions), key: "weather", getter: false, setter: false  },
    clouds: { type: Int32, key: "clouds", root: "all", default: 0, setter: false },
    rain: { type: Rain, default: Rain.new, setter: false },
    snow: { type: Snow, default: Snow.new, setter: false },
  )

  struct Coord
    JSON.mapping(
      lon: { type: Float64, setter: false },
      lat: { type: Float64, setter: false },
    )
  end

  # Returns the time passed since the instantiation of the object. Useful for
  # checking how recent the weather data is.
  def timePassed
    Time.now - @time
  end

  # Outputs weather in a human readable format.
  # def simple_output
  #  output = "Temperature in #{@name} at #{@time} is #{@temp} degrees, with #{@weather_description}. "
#
#    if @wind_speed > 5 && @temp < 10
#      windChill = (13.12 + 0.6215 * @temp - 11.37 * @wind_speed ** 0.16 + 0.3965 * @temp * @wind_speed ** 0.16).round(1)
#      output += "Wind Speed is #{(@wind_speed * 3.6).round(1)}k/h, with a windchill of #{windChill} degrees."
#    else
#      output += "Wind Speed is #{(@wind_speed * 3.6).round(1)}km/h."
#    end

#    output
#  end
end
