require "json"

struct OWM::Weather
  include JSON::Serializable

  getter id : Int32
  getter main : String
  getter description : String
  getter icon : String
end
