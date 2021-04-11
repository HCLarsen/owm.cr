require "webmock"

WebMock.stub(:get, "http://api.openweathermap.org/data/2.5/weather?APPID=InvalidKey&q=Mississauga").to_return(status: 401, body: File.read("test/files/invalid.json"))

WebMock.stub(:get, "http://api.openweathermap.org/data/2.5/weather?APPID=NOTAREALKEY&f=Mississauga").to_return(status: 400, body: File.read("test/files/400.json"))

WebMock.stub(:get, "http://api.openweathermap.org/data/2.5/weather?APPID=NOTAREALKEY&q=Mississauga").to_return(status: 200, body: File.read("test/files/mississauga.json"))

WebMock.stub(:get, "http://api.openweathermap.org/data/2.5/forecast?APPID=NOTAREALKEY&q=Mississauga").to_return(status: 200, body: File.read("test/files/forecast.json"))

WebMock.stub(:get, "http://api.openweathermap.org/data/2.5/group?APPID=NOTAREALKEY&id=6075357%2C5907364%2C5969785").to_return(status: 200, body: File.read("test/files/cities.json"))

WebMock.stub(:get, "http://api.openweathermap.org/data/2.5/weather?APPID=NOTAREALKEY&lat=43.5&lon=-79.5").to_return(status: 200, body: File.read("test/files/coords.json"))
