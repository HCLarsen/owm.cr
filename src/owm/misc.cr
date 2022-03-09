require "json"

module OWM
  struct Weather
    include JSON::Serializable

    getter id : Int32
    getter main : String
    getter description : String
    getter icon : String
  end

  struct Coord
    include JSON::Serializable

    getter lon : Float64
    getter lat : Float64
  end

  
  # The OWM API returns rain and snow data in one of three ways. Either no top level key at all, a Rain/Snow key with an empty subobject, or a subobject with a key of "3h." The following structs and corresponding getters process all three versions properly.

  struct Precipitation
    getter amount : Float64 = 0.0
    getter duration : String = "1h"

    def initialize(parser : JSON::PullParser)
      parser.read_object_or_null do |key|
        if !key.nil?
  				@duration = key
          @amount = parser.read_float
        end
      end
    end

    def initialize; end
  end
end
