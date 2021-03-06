# Crystal Open Weather Map Interface

A Crystal interface for the Open Weather Map API. Currently, this library supports all the options available to Free Accounts, with the exception of Weather Map Layers.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  owm:
    github: HCLarsen/owm.cr
```

## Usage

```crystal
require "owm"

client = OWM::Client.new(USERS_OWM_KEY)
params = { "q" => "Toronto" }
currentWeather = client.current_weather_for_city(params)

puts "The current weather in Toronto is #{currentWeather.temp}"
```

Note: Users must obtain their own API key from http://OWM.org/appid, and substitute their key as USERS_OWM_KEY.

## Development

### To Do

1. Add Air Pollution API wrapper.
2. Add geocoding API wrapper.

## Contributing

1. Fork it ( https://github.com/HCLarsen/owm/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [HCLarsen](https://github.com/HCLarsen) Chris Larsen - creator, maintainer
