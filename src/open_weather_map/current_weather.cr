require "./weather"

# Contains all the information on the current weather status for any city.
class OpenWeatherMap::CurrentWeather < OpenWeatherMap::Weather
  JSON.mapping(
    name: { type: String, setter: false },
    id: { type: Int32, setter: false },
    country: { type: String, key: "sys", root: "country", setter: false },
    time: { type: Time, key: "dt", setter: false, converter: Time::EpochConverter },
    coord: { type: Coord, getter: false, setter: false },
    main: { type: Main, getter: false, setter: false },
    wind: { type: Wind, getter: false, setter: false },
    conditions: { type: Array(Conditions), key: "weather", setter: false  },
    clouds: { type: Int32, root: "all", default: 0, setter: false },
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

  def rain
    @rain.rain
  end

  def snow
    @snow.snow
  end
end
