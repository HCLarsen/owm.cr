module OWM
  struct Precipitation
    getter amount : Float64 = 0.0
    getter duration : String = "1h"

    def initialize(parser : JSON::PullParser)
      parser.read_begin_object
      @duration = parser.read_object_key
      @amount = parser.read_float
      parser.read_end_object
    end

    def initialize; end
  end
end
