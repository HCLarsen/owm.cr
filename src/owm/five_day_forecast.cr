require "./conditions"

# Provides a 5 day weather forecast, with 3 hour intervals.
class OWM::FiveDayForecast
  include JSON::Serializable

  getter list : Array(Conditions)
  @city : City

  struct City
    include JSON::Serializable

    getter name : String
    getter id : Int32
    getter country : String
    getter coord : OWM::Coord
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
