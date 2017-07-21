require("rspec")
  require("pg")
  require("brand")
  require('store')

  DB = PG.connect({:dbname => "shoe_distribution_test"})

  RSpec.configure do |config|
    config.after(:each) do
      DB.exec("DELETE FROM brand *;")
      DB.exec("DELETE FROM store *;")
    end
  end
