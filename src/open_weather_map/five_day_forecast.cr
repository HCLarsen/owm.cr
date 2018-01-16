require "./weather"

# Provides a 5 day weather forecast, with 3 hour intervals.
class OpenWeatherMap::FiveDayForecast
  JSON.mapping(
    list: { type: Array(Weather) },
    city: { type: City, getter: false, setter: false }
  )

  struct City
    JSON.mapping(
      name: { type: String, setter: false },
      id: { type: Int32, setter: false },
      country: { type: String, setter: false },
      coord: { type: Coord, setter: false },
    )
  end

  struct Coord
    JSON.mapping(
      lon: { type: Float64, setter: false },
      lat: { type: Float64, setter: false },
    )
  end

  # Macros that create top level getter methods for nested properties.
  {% for name in %w[name id country] %}
    def {{name.id}}
      @city.{{name.id}}
    end
  {% end %}

  {% for name in %w[lon lat] %}
    def {{name.id}}
      @city.coord.{{name.id}}
    end
  {% end %}
end
