require "webmock"

WebMock.stub(:get, "https://api.openweathermap.org/data/2.5/weather?appid=InvalidKey&q=Mississauga").to_return(status: 401, body: File.read("test/files/invalid.json"))

WebMock.stub(:get, "https://api.openweathermap.org/data/2.5/weather?appid=NOTAREALKEY&f=Mississauga").to_return(status: 400, body: File.read("test/files/400.json"))

WebMock.stub(:get, "https://api.openweathermap.org/data/2.5/weather?appid=NOTAREALKEY&q=Mississauga").to_return(status: 200, body: File.read("test/files/mississauga.json"))

WebMock.stub(:get, "https://api.openweathermap.org/data/2.5/forecast?appid=NOTAREALKEY&q=Mississauga").to_return(status: 200, body: File.read("test/files/forecast.json"))

WebMock.stub(:get, "https://api.openweathermap.org/data/2.5/group?appid=NOTAREALKEY&id=6075357%2C5907364%2C5969785").to_return(status: 200, body: File.read("test/files/cities.json"))

WebMock.stub(:get, "https://api.openweathermap.org/data/2.5/weather?appid=NOTAREALKEY&lat=43.5&lon=-79.5").to_return(status: 200, body: File.read("test/files/coords.json"))

WebMock.stub(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=NOTAREALKEY&lat=43.5789&lon=-79.6583").to_return(status: 200, body: File.read("test/files/onecall.json"))

WebMock.stub(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=NOTAREALKEY&lat=43.5789&lon=-79.6583").to_return(status: 200, body: File.read("test/files/weekdayweather.json"))
