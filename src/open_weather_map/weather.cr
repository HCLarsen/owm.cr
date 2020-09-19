require "json"

# Custom converters for values that may appear as an Int or as a Float
class NumToInt
  def self.from_json(pull : JSON::PullParser)
    case pull.kind
    when JSON::PullParser::Kind::Float
      pull.read_float.round.to_i
    when JSON::PullParser::Kind::Int
      pull.read_int.to_i
    else
      raise "Expected float or int but was #{pull.kind}"
    end
  end
end

class NumToFloat
  def self.from_json(pull : JSON::PullParser)
    case pull.kind
    when JSON::PullParser::Kind::Int
      pull.read_int.to_f
    when JSON::PullParser::Kind::Float
      pull.read_float
    else
      raise "Expected float or int but was #{pull.kind}"
    end
  end
end

# Contains all the information on the current weather status for any city.
class OpenWeatherMap::Weather
  include JSON::Serializable

  @[JSON::Field(key: "dt", converter: Time::EpochConverter)]
  getter time : Time
  @main : Main
  @wind : Wind
  @[JSON::Field(key: "weather")]
  getter conditions : Array(Conditions)
  @[JSON::Field(root: "all")]
  getter clouds : Int32 = 0
  @rain : Rain = OpenWeatherMap::Weather::Rain.new
  @snow : Snow = OpenWeatherMap::Weather::Snow.new

  # Structs for mapping the json subobjects within returned data.
  struct Main
    include JSON::Serializable

    getter temp : Float64
    @[JSON::Field(converter: NumToInt)]
    getter pressure : Int32
    getter humidity : Int32
    getter temp_min : Float64
    getter temp_max : Float64
    @[JSON::Field(converter: NumToInt)]
    getter grnd_level : Int32?
    @[JSON::Field(converter: NumToInt)]
    getter sea_level : Int32?
  end

  struct Conditions
    include JSON::Serializable

    getter id : Int32
    getter main : String
    getter description : String
    getter icon : String
  end

  struct Wind
    include JSON::Serializable

    @[JSON::Field(converter: NumToInt)]
    getter speed : Int32

    @[JSON::Field(converter: NumToInt)]
    getter deg : Int32

    @[JSON::Field(converter: NumToInt)]
    getter gust : Int32 = 0
  end

  # The OpenWeatherMap API returns rain and snow data in one of three ways. Either no top level key at all, a Rain/Snow key with an empty subobject, or a subobject with a key of "3h." The following structs and corresponding getters process all three versions properly.

  struct Rain
    include JSON::Serializable

    @[JSON::Field(key: "3h")]
    getter rain : Float64 = 0.0

    def initialize
      @rain = 0.0
    end
  end

  struct Snow
    include JSON::Serializable

    @[JSON::Field(key: "3h")]
    getter snow : Float64 = 0.0

    def initialize
      @snow = 0.0
    end
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

  {% for name in %w[speed deg gust] %}
    def wind_{{name.id}}
      @wind.{{name.id}}
    end
  {% end %}
end
