require "http/client"
require "json"

city = "Mississauga"
response = HTTP::Client.get "http://api.openweathermap.org/data/2.5/weather?APPID=83658a490b36698e09e779d265859910&q=#{URI.escape(city)}"
puts response.status_code
value = JSON.parse(response.body)

#string = %({"coord":{"lon":-79.66,"lat":43.58},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"base":"stations","main":{"temp":292.49,"pressure":1017,"humidity":63,"temp_min":291.15,"temp_max":294.15},"visibility":24140,"wind":{"speed":3.6,"deg":150},"clouds":{"all":90},"dt":1507320000,"sys":{"type":1,"id":3722,"message":0.004,"country":"CA","sunrise":1507288997,"sunset":1507330127},"id":6075357,"name":"Mississauga","cod":200})
#value = JSON.parse(string)

temp = (value["main"]["temp"].as_f - 273.15).round(1)
description = value["weather"][0]["description"]
windSpeed = value["wind"]["speed"].as_f
output = "Temperature is #{temp} degrees, with #{description}. "

if windSpeed > 5 && temp < 10
  windChill = (13.12 + 0.6215 * temp - 11.37 * windSpeed ** 0.16 + 0.3965 * temp * windSpeed ** 0.16).round(1)
  output += "Wind Speed is #{windSpeed * 3.6}k/h, with a windwchill of #{windChill} degrees."
else
  output += "Wind is #{windSpeed * 3.6}k/h."
end

puts output
