struct OWM::Coord
  include JSON::Serializable

  getter lon : Float64
  getter lat : Float64
end
