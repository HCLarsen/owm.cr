require "json"

# Contains all the information on the current weather status for any city.
class OpenWeatherMap::Weather
  # Custom converters for values that may appear as an Int or as a Float
  class NumToInt
    def self.from_json(pull : JSON::PullParser)
      case pull.kind
      when :float
        pull.read_float.round.to_i
      when :int
        pull.read_int.to_i
      else
        raise "Expected float or int but was #{pull.kind}"
      end
    end
  end

  class NumToFloat
    def self.from_json(pull : JSON::PullParser)
      case pull.kind
      when :int
        pull.read_int.to_f
      when :float
        pull.read_float
      else
        raise "Expected float or int but was #{pull.kind}"
      end
    end
  end

  JSON.mapping(
    time: { type: Time, key: "dt", setter: false, converter: Time::EpochConverter },
    main: { type: Main, getter: false, setter: false },
    wind: { type: Wind, getter: false, setter: false },
    conditions: { type: Array(Conditions), key: "weather", getter: false, setter: false  },
    clouds: { type: Int32, key: "clouds", root: "all", default: 0, setter: false },
    rain: { type: Rain, default: Rain.new, setter: false },
    snow: { type: Snow, default: Snow.new, setter: false },
  )

  # Structs for mapping the json subobjects within returned data.
  struct Main
    JSON.mapping(
      temp: { type: Float64 },
      pressure: { type: Int32, converter: NumToInt },
      humidity: { type: Int32 },
      temp_min: { type: Float64 },
      temp_max: { type: Float64 },
      grnd_level: { type: Int32, converter: NumToInt, nilable: true },
      sea_level: { type: Int32, converter: NumToInt, nilable: true },
    )
  end

  struct Conditions
    JSON.mapping(
      id: { type: Int32},
      main: { type: String },
      description: { type: String },
      icon: { type: String },
    )
  end

  struct Wind
    JSON.mapping(
      speed: { type: Int32, setter: false, converter: NumToInt  },
      deg: { type: Int32, setter: false, converter: NumToInt  },
    )
  end

  # The OpenWeatherMap API returns rain and snow data in one of three ways. Either no top level key at all, a Rain/Snow key with an empty subobject, or a subobject with a key of "3h." The following structs and corresponding getters process all three versions properly.

  struct Rain
    def initialize
      @rain = 0.0
    end

    JSON.mapping(
      rain: { type: Float64, key: "3h", default: 0.0 }
    )
  end

  struct Snow
    def initialize
      @snow = 0.0
    end

    JSON.mapping(
      snow: { type: Float64, key: "3h", default: 0.0 }
    )
  end

  def rain
    @rain.rain
  end

  def snow
    @snow.snow
  end

  # Custom Getters
  def sea_level
    @main.sea_level || @main.pressure
  end

  def grnd_level
    @main.grnd_level || @main.pressure
  end

  # Macros that create top level getter methods for nested properties.
  {% for name in %w[lon lat] %}
    def {{name.id}}
      @coord.{{name.id}}
    end
  {% end %}

  {% for name in %w[temp pressure humidity temp_min temp_max] %}
    def {{name.id}}
      @main.{{name.id}}
    end
  {% end %}

  {% for name in %w[id main description icon] %}
    def weather_{{name.id}}
      @conditions[0].{{name.id}}
    end
  {% end %}

  {% for name in %w[speed deg] %}
    def wind_{{name.id}}
      @wind.{{name.id}}
    end
  {% end %}
end
