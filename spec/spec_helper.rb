ENV['RAKE_ENV'] = 'test'
require("rspec")
  require("pg")
  require("store")
  require('brand')

  RSpec.configure do |config|
    config.after(:each) do
      DB.exec("DELETE FROM stores *;")
      DB.exec("DELETE FROM brands *;")
    end
  end
