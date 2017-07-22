require("rspec")
  require("pg")
  require("store")
  require('brand')

  DB = PG.connect({:dbname => "shoe_database_test"})

  RSpec.configure do |config|
    config.after(:each) do
      DB.exec("DELETE FROM stores *;")
      DB.exec("DELETE FROM brands *;")
    end
  end
