require("sinatra")
  require("sinatra/reloader")
  also_reload("lib/**/*.rb")
  require("sinatra/activerecord")
  require("./lib/brand")
  require("./lib/store")
  require("pg")

  get("/") do
    @brands = Brand.all()
    @stores = Store.all()
    erb(:index)
  end

  get("/brands") do
    @brands = Brand.all()
    @stores = Store.all()
    erb(:brands)
  end

  get("/stores") do
    @stores = Store.all()
    erb(:stores)
  end

  post("/brands") do
    name = params.fetch("name")
    description = params.fetch("description")
    brand = Brand.new({:name => name, :description => description, :id => nil})
    brand.save()
    @brands = Brand.all()
    @stores = Store.all()
    erb(:brands)
  end

  post("/stores") do
    name = params.fetch("name")
    store = Store.new({:name => name, :id => nil})
    store.save()
    @stores = Store.all()
    erb(:stores)
  end

  get("/brands/:id") do
    @stores = Store.all()
    @brand = Brand.find(params.fetch("id").to_i())
    erb(:brand_info)
  end

  get("/stores/:id") do
    @store = Store.find(params.fetch("id").to_i())
    @brands = Brand.all()
    erb(:store_info)
  end

  patch("/brands/:id") do
    brand_id = params.fetch("id").to_i()
    @brand = Brand.find(brand_id)
    store_ids = params.fetch("store_ids")
    @brand.update({:store_ids => store_ids})
    @stores = Store.all()
    erb(:brand_info)
  end

  patch("/stores/:id") do
    store_id = params.fetch("id").to_i()
    @store = Store.find(store_id)
    brand_ids = params.fetch("brand_ids")
    @store.update({:brand_ids => brand_ids})
    @brands = brand.all()
    erb(:store_info)
  end

  delete("/stores/:id") do
    @store = Store.find(params.fetch("id").to_i())
    if @store.destroy()
      redirect("/stores")
    else
      erb(:error)
    end
  end

  delete("/brands/:id") do
    @brand = Brand.find(params.fetch("id").to_i())
    if @brand.destroy()
      redirect("/brands")
    else
      erb(:error)
    end
  end
