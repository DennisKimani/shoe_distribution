require("sinatra")
  require("sinatra/reloader")
  also_reload("lib/**/*.rb")
  require("./lib/brand")
  require("./lib/store")
  require("pg")

  DB = PG.connect({:dbname => "shoe_distribution"})
