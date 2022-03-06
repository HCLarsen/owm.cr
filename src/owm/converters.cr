require "json"

struct Int32::NumberConverter
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
